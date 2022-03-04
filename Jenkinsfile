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
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                        EC2_PUBLIC_IP = sh(
                            script: "terraform output ec2_public_ip",
                            returnStdout: true
                        ).trim()
                    }
                }
            }
        }

        
    }
}
