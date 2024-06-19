# Use a base image with JDK 11
FROM adoptopenjdk/openjdk11-openj9

ENV APP_HOME=/usr/apps
ENV APP_PORT_DEV=8080

# Set the working directory within the Docker container
WORKDIR $APP_HOME

# Copy the application JAR file to the container
#COPY target/*.jar .
COPY target/spring-boot-github-slack-0.0.1-SNAPSHOT.jar .

# Expose the port the application runs on
EXPOSE $APP_PORT_DEV

# Run the application when a container starts
CMD ["java", "-jar", "spring-boot-github-slack-0.0.1-SNAPSHOT.jar"]

