pipeline {
  agent any
  stages {
    stage('Build') {
      agent any
      steps {
        sh 'mvn clean package -DskipTests'
        sh 'docker compose build'
      }
    }

    stage('Start container') {
      steps {
        sh 'docker compose build'
        sh 'docker compose ps'
      }
    }

    stage('Stop container') {
      steps {
        sh 'docker compose down --remove-orphans -v'
        sh 'docker compose ps'
      }
    }

  }
}