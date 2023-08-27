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

    stage('Deploy to Nexus ') {
      steps {
        sh 'mvn clean package'
        script {
          pom = readMavenPom file: "pom.xml";
          filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
          echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
          artifactPath = filesByGlob[0].path;
          artifactExists = fileExists artifactPath;
          if(artifactExists) {
            echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
            nexusArtifactUploader(
              nexusVersion: "nexus3",
              protocol: "http",
              nexusUrl: "localhost:8081",
              groupId: pom.groupId,
              version: pom.version,
              repository: "DevOps-Demo-Repo",
              credentialsId: "nexus-user-credentials",
              artifacts: [
                [artifactId: pom.artifactId,
                classifier: '',
                file: artifactPath,
                type: pom.packaging],
                [artifactId: pom.artifactId,
                classifier: '',
                file: "pom.xml",
                type: "pom"]
              ]
            );
          } else {
            error "*** File: ${artifactPath}, could not be found";
          }
        }

      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        script {
          withKubeConfig([credentialsId: 'minikube-config']) {
            sh 'kubectl apply -f postgres-config.yaml'
          }
      }
    }

  }
  tools {
    maven 'Maven'
  }
}
}
