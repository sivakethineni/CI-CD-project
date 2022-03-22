node{
   stage("CheckOutCode")
    {
        checkout([$class: 'GitSCM', branches: [[name: '*/docker-new']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sivakethineni/CI-CD-project.git']]])
    }
    
    stage("Build")
    {
        sh 'mvn install'
    }
    
   stage('Build Docker Image'){
     sh 'mkdir -p Docker-app/target'
     sh 'cp target/vprofile-v2.war Docker-app/target/'
     sh 'docker build -t vevadevops/vproappfix:$BUILD_ID Docker-app/'
     sh 'docker tag vevadevops/vproappfix:$BUILD_ID vevadevops/vproappfix:latest'
   }
   
  stage('Push Docker Image'){ 
   withDockerRegistry(credentialsId: 'docker-hub-pwd', url: 'https://index.docker.io/v1/') {
    sh 'docker push vevadevops/vproappfix'
   }
 }
  stage('Deploy Docker Container into Docker Dev Server'){
     script {
     def dockerRun = 'docker run -p 8080:8080 -d --name vproapp vevadevops/vproappfix'
   sshagent(['docker-server-pwd']) {
    
    sh "scp -o StrictHostKeyChecking=no compose/* ubuntu@172.31.3.118:/home/ubuntu"
    sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.3.118 cd /home/ubuntu"
    sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.3.118 docker-compose up -d"
    }
     }
  }   
}
