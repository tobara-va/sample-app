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
                    VERTAG = sh (
                        script: 'docker image ls --format \'table {{.Tag}}\' sample-app | sed -n \'2 p\'',
                        returnStdout: true
                    )
                    echo "The latest tag is ${VERTAG}"
                    env.VERTAG = "${VERTAG}"
                    docker.withRegistry( 'https://registry.obara.xyz', '689b33b5-2795-4052-9561-b7c636e23e96' ) {
                        def customImage = docker.image("sample-app")
                        customImage.push("dev")
                        customImage.push("${VER_TAG}")
                    }
                }
            }
        }
    }
}