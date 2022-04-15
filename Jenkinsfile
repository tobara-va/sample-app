pipeline {
    agent { label 'VMagent' }
    stages{
        stage('Build Images') { // for display purposes
            steps {
                sh 'bash scripts/build.sh'
            }
        }
        stage('Push Images') {
            steps{
                script {
                    VER_TAG = sh (
                        script: 'docker image ls --format \'table {{.Tag}}\' sample-app | sed -n \'2 p\'',
                        returnStdout: true
                    )
                    echo "The latest tag is ${VER_TAG}"
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