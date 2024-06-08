# Use a multi-stage build to keep the final image small
# First stage: build the application
FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Second stage: create the final image
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/springboot-service-1.0.0.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
