pipeline {
  agent any
  stages {
    stage('Build') {
      agent any
      steps {
        sh 'docker system prune -a --volumes -f'
        sh 'mvn clean package '
      }
    }

    stage('Start') {
      steps {
        sh 'docker compose build'
        sh 'docker compose up --wait'
      }
    }

    stage('Test') {
      steps {
        sh 'mvn test'
      }
    }

    stage('Stop app') {
      steps {
        sh 'docker compose down --remove-orphans -v'
      }
    }

  }
}