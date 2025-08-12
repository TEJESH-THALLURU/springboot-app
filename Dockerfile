# Stage 1: Build the application
FROM maven:3.8.5-openjdk-8-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml file to the working directory
COPY pom.xml .

# Download dependencies (without building the project yet)
RUN mvn dependency:go-offline -B

# Copy the entire project source code to the working directory
COPY src ./src

# Package the application (build the JAR file)
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM openjdk:8-alpine

# Set environment variables using the recommended format
ENV PROJECT_HOME=/opt/app

WORKDIR $PROJECT_HOME

# Copy the JAR file from the previous stage
COPY --from=build /app/target/spring-boot-mongo-1.0-SNAPSHOT.jar $PROJECT_HOME/mongospring.jar


# Expose port 8080
EXPOSE 8080

CMD ["java", "-jar", "/opt/app/spring-boot-mongo-1.0-SNAPSHOT.jar"]

