pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                script {
                      def gitRepoUrl = 'https://github.com/agraharibrijesh/devops_pract.git'
                      checkout([$class: 'GitSCM', branches: [[name: 'weather-app']],
                       userRemoteConfigs: [[url: gitRepoUrl]]])
                }
            }
        }
        
        stage('Build-image and push-docker hub') {
            steps {
                script {
                        //sh 'sudo docker rmi -f \$(docker images -q)'
                        sh "docker images -q | grep -v '67a4b1138d2d' | xargs -I {} docker rmi -f {}"
                        sh "sudo docker-compose build"
                           withCredentials([usernamePassword(credentialsId: 'dockercred', 
                           usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh "sudo docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD"
                        sh "sudo docker push brijesh35/my-weather-app:1.0" 
                    }
                }
            }
        } 
        
        stage('kubernetes deployment') {
            steps {
                script {
                   withKubeConfig([credentialsId: 'mymini_cred']) {
                        sh "kubectl apply -f job_dep.yml"                            
                        sh "kubectl apply -f service.yml"
                        sh  "kubectl get pod"
                        sh  "kubectl get deployment"                    
                   }
                }
            }
        }
    }
}
