pipeline {
    agent { label 'VMagent' }
    stages{
        stage('Preparation') { // for display purposes
            steps {
                sh "export TAG=$(grep \'Welcome to nginx \' index.html | awk \'{print $4}\' | awk -F \'!\' \'{print $1}\')"
                sh 'ls'
                sh "docker build -t sample-app:${TAG} ."
                // script {
                //     docker.image("nginx").run('--net="custom" --name nginx')
                // }
            }
        }
    }
    // stage('Push Image') {
    //     steps{
    //         script {
    //             docker.withRegistry( 'https://registry.obara.xyz', '689b33b5-2795-4052-9561-b7c636e23e96' ) {
    //                 image = docker.image('sample-app:0.0.1')
    //                 image.push()
    //             }
    //         }
    //     }
    // }
}