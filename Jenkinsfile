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
        
    }
}
