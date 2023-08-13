pipeline {
  agent any
  stages {
    stage('Build and start application') {
      agent any
      steps {
        sh 'docker system prune -a --volumes -f'
        sh 'mvn clean package '
        sh 'docker compose build'
        sh 'docker compose up --wait'
      }
    }

    stage('Stop application') {
      steps {
        sh 'docker compose down --remove-orphans -v'
      }
    }

    stage('Test') {
      steps {
        sh 'mvn test'
      }
    }

  }
}