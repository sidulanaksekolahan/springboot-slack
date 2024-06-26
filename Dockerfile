# Use a base image with JDK 11
FROM adoptopenjdk/openjdk11-openj9

ENV APP_HOME=/usr/apps
ENV APP_PORT_DEV=8080
ARG SPRING_MSSQL_PASSWORD

# Set a default value if SPRING_MSSQL_PASSWORD is not provided
ENV SPRING_MSSQL_PASSWORD=${SPRING_MSSQL_PASSWORD:-defaultpassword}

# Set the working directory within the Docker container
WORKDIR $APP_HOME

# Copy the application JAR file to the container
COPY target/*.jar app.jar

# Expose the port the application runs on
EXPOSE $APP_PORT_DEV

# Run the application when a container starts
CMD java -jar app.jar --SPRING_MSSQL_PASSWORD=${SPRING_MSSQL_PASSWORD}

