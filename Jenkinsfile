pipeline {
    agent any
    environment{
        DOCKER_TAG = getDockerTag()
    }
    stages{
        stage('Build Docker Image'){
            steps{
                sh "docker build . -t devopsb5/nodeapp1:v1 "
            }
        }
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u devopsb5 -p ${dockerHubPwd}"
                    sh "docker push devopsb5/nodeapp1:v1"
                }
            }
        }
        stage('Deploy to k8s'){
            steps{
                sshagent ('k8s-master') {
				sh "ssh -o StrictHostKeyChecking=no services.yml node-app-pod.yml ubuntu@3.80.32.247:/home/ubuntu/"
				    script{
					    
						try{
						sh "ssh ubuntu@3.80.32.247 kubectl apply -f ."
						}catch(error) {
						sh "ssh ubuntu@3.80.32.247 kubectl create -f ."
						}
						
					}
				}
            }
        }
    }
}

def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}



