pipeline {
    agent { label 'VMagent' }
    stages{
        stage('Build Images') { // for display purposes
            steps {
                sh 'bash scripts/build.sh'
                VER_TAG = sh (
                    script: 'docker image ls --format \'table {{.Tag}}\' sample-app | sed -n \'2 p\'',
                    returnStatus: true
                ).trim()
                // script {
                //     docker.image("nginx").run('--net="custom" --name nginx')
                // }
            }
        }
        stage('Push Images') {
            steps{
                script {
                    docker.withRegistry( 'https://registry.obara.xyz', '689b33b5-2795-4052-9561-b7c636e23e96' ) {
                        image = docker.image("sample-app:dev")
                        image.push()
                        image = docker.image("sample-app:${VER_TAG}")
                        image.push()
                    }
                }
            }
        }
    }
}