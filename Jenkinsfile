pipeline{
    agent any
    environment {
    registry = "ragulnd/testnodejs"
    registryCredential = ‘dockerhub’
    dockerImage=''
  }
    stages{

       stage('Cloning Git') {
      steps {
        git 'https://github.com/gustavoapolinario/node-todo-frontend'
      }
    }
    stage('Build') {
       steps {
         sh 'cd $PWD/node_app && npm install'
       }
    }

    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Deploy Image') {
      steps{
         script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
    }
}

