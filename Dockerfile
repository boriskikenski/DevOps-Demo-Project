FROM openjdk:17
COPY target/devops-0.0.1-SNAPSHOT.jar devops.jar
ENTRYPOINT ["java","-jar","/devops.jar"]