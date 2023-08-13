pipeline {
  agent any
  stages {
    stage('Build') {
      agent any
      steps {
        sh 'docker system prune -a --volumes -f'
        sh 'mvn clean package '
        sh 'docker compose build'
        sh 'docker compose up --wait'
      }
    }

    stage('Start container') {
      steps {
        sh 'mvn test'
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