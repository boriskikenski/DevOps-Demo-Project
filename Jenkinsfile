pipeline {
  agent any
  stages {
    stage('Build') {
      agent any
      steps {
        sh 'mvn clean package -DskipTests'
        sh '''docker-compose up
'''
      }
    }

  }
}