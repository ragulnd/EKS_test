pipeline{
    agent any
    environment {
    registry = "ragulnd/testnodejs"
    registryCredential = 'dockerhub'
    dockerImage=''
    kubeconfigId= 'kubenetes'
  }
    stages{

       stage('Cloning Git') {
      steps {
        git 'https://github.com/ragulnd/EKS_test.git'
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
    stage('K8 Deploy') {
      steps{
        script{
          kubernetesDeploy(
            configs: 'node_deployment.yaml',
             enableConfigSubstitution: true
            )
        }
      }
    }
  }
}

