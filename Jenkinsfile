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
   
  stage('Build Docker Image'){ 
   withDockerRegistry(credentialsId: 'cba64e86-2f4e-4621-ae44-51ecb1a65982', url: 'https://hub.docker.com/') {
    sh 'docker push vevadevops/vproappfix'
   }
}
