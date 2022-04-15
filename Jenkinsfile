pipeline {
    agent { label 'VMagent' }
    stages{
        stage('Build Images') { // for display purposes
            steps {
                sh 'bash scripts/build.sh'
            }
        }
        stage('Generate SBOM') {
            steps{
                sh 'syft sample-app:dev -o json --file sample-app-sbom.json'
                archiveArtifacts artifacts: 'sample-app-sbom.json'
            }
        }
        stage('Scan SBOM') {
            steps{
                sh 'grype sbom:sample-app-sbom.json --file sample-app-grype.txt'
                archiveArtifacts artifacts: 'sample-app-grype.txt'
            }
        }
        stage('Efficiency Metrics') {
            steps{
                sh 'CI=true dive sample-app:dev | tee sample-app-dive.txt'
                archiveArtifacts artifacts: 'sample-app-dive.txt'
            }
        }
        stage('Push Images') {
            steps{
                script {
                    env.VERTAG = sh (
                        script: 'docker image ls --format \'table {{.Tag}}\' sample-app | sed -n \'2 p\'',
                        returnStdout: true
                    ).trim()
                    docker.withRegistry( 'https://registry.obara.xyz', '689b33b5-2795-4052-9561-b7c636e23e96' ) {
                        def customImage = docker.image("sample-app:dev")
                        customImage.push("dev")
                        customImage.push("${VERTAG}")
                    }
                }
            }
        }
    }
}