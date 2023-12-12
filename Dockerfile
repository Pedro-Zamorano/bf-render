# Stage 1: Build the application
FROM maven:3.8.4-openjdk-17 AS build

WORKDIR /app
COPY . .

RUN mvn clean install

# Stage 2: Create a minimal runtime image
FROM adoptopenjdk:17-jre-hotspot

WORKDIR /app

COPY --from=build /app/target/backend-1.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]