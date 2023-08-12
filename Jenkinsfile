pipeline {
  agent any
  stages {
    stage('Build') {
      agent any
      steps {
        sh 'mvn clean package -DskipTests'
        sh '''/usr/local/bin/docker compose up
'''
      }
    }

  }
}