#!/usr/bin/env groovy

pipeline {
    agent any
    
    stages {
        
        stage('build app') {
            steps {
               script {
                  sh 'mvn install'
               }
            }
        }
        
       stage('Build Docker Image') {
            steps {
               script {
                  sh 'mkdir -p Docker-app/target'
                  sh 'cp target/vprofile-v2.war Docker-app/target/'
                  sh 'docker build -t vevadevops/vproappfix:$BUILD_ID Docker-app/'
                  sh 'docker tag vevadevops/vproappfix:$BUILD_ID vevadevops/vproappfix:latest'
               }
            }
        } 
        
        stage('Push Docker Image') {
            steps {
               script {
                  withDockerRegistry(credentialsId: '6fd8c669-1257-4852-b301-ce3dbfa472f9', url: 'https://index.docker.io/v1/') {
                  sh 'docker push vevadevops/vproappfix'
                 }
               }
            }
        } 
        
        stage('provision server') {
            environment {
                AWS_ACCESS_KEY_ID = credentials('jenkins_aws_access_key_id')
                AWS_SECRET_ACCESS_KEY = credentials('jenkins_aws_secret_access_key')
            }
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init -migrate-state"
                        sh "terraform apply --auto-approve"
                        EC2_PUBLIC_IP = sh(
                            script: "terraform output ec2_public_ip",
                            returnStdout: true
                        ).trim()
                    }
                }
            }
        }
           
        stage('deploy') {
            environment {
                IMAGE_NAME = 'vevadevops/vproappfix:latest'
            }        
            steps {
                script {
                   echo "waiting for EC2 server to initialize" 
                   sleep(time: 30, unit: "SECONDS") 

                   echo 'deploying docker image to EC2...'
                   echo "${EC2_PUBLIC_IP}"

                   def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME}"
                   def ec2Instance = "ec2-user@${EC2_PUBLIC_IP}"

                   sshagent(['server-ssh-key']) {
                       sh "scp -o StrictHostKeyChecking=no server-cmds.sh ${ec2Instance}:/home/ec2-user"
                       sh "scp -o StrictHostKeyChecking=no docker-compose.yaml ${ec2Instance}:/home/ec2-user"
                       sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${shellCmd}"
                   }
                }
            }
        }

        
        
    }
}
