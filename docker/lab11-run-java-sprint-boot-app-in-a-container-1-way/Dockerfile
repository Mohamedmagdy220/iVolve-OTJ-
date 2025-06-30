# Use Maven base image with Java 17
FROM maven:3.9.10-eclipse-temurin-17-alpine

# Create app directory
WORKDIR /app

# Copy application code
COPY . .

# Build the app
RUN mvn clean package

# Use a minimal JDK image for runtime
FROM openjdk:17-jdk-slim

# Set work directory
WORKDIR /app

# Copy the built jar from the builder stage
COPY --from=builder /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]

# Expose port
EXPOSE 8080
