# Use Maven base image
FROM maven:3.9.10-eclipse-temurin-17-alpine AS build

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Build the app
RUN mvn clean package

# =========================
# مرحلة التشغيل
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the built JAR from previous stage
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

# Expose port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
