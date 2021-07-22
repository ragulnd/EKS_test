pipeline{
    agent any
    environment {
    registry = "ragulnd/testnodejs"
    registryCredential = 'dockerhub'
    dockerImage=''
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
        sh 'chmod +x $PWD/tagchange.sh'
        sh './$PWD/tagchange.sh '$BUILD_NUMBER''
        script{
          kubernetesDeploy(
            configs: '$PWD/kb/node_deployment.yaml',
            kubeconfigId: 'kubenetes',
             enableConfigSubstitution: true
            )
        }
      }
    }
  }
}

