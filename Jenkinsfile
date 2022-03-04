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
        
    }
}
