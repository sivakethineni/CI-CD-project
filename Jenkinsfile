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
        
    }
}
