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
     sh 'ls'
     sh 'docker build -t vevadevops/vproappfix:$BUILD_ID Docker-app/'
     sh 'docker tag vevadevops/vproappfix:$BUILD_ID vevadevops/vproappfix:latest'
   }
   
  
}
