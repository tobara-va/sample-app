pipeline {
    agent { label 'PiAgent' }
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
                sh 'grype sbom:sample-app-sbom.json --file sample-app-grype.txt --fail-on critical'
                archiveArtifacts artifacts: 'sample-app-grype.txt'
            }
        }
        stage('Efficiency Metrics') {
            steps{
                sh 'printf "rules:\n  highestUserWastedPercent: 0.30" > dive-ci'
                sh 'docker run -v /var/run/docker.sock:/var/run/docker.sock -v "$(pwd)/dive-ci:/config/.dive-ci" jauderho/dive --ci --ci-config /config/.dive-ci sample-app:dev >> sample-app-dive.txt'
                archiveArtifacts artifacts: 'sample-app-dive.txt'
            }
        }
        stage('Check Git Secrets') {            
            steps {                              
                sh 'docker run -it -v "$PWD:/pwd" trufflesecurity/trufflehog:latest github --repo https://github.com/tobara8/sample-app.git > sample-app-trufflehog.txt'                
                archiveArtifacts artifacts: 'sample-app-trufflehog.txt'            
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