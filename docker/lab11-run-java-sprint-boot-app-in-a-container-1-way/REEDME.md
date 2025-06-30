# 🛠️ Spring Boot Docker App – Single-Stage Build & Run (Maven + Java)

This guide explains how to containerize and run a Spring Boot application using a single-stage Dockerfile where both **build** and **execution** happen in the same image.

---

## 📌 Project Overview

This is a simple Spring Boot application demonstrating how to:

- Package a Spring Boot app using Maven
- Containerize it using a single Dockerfile
- Run it in a lightweight Java-based Docker container

---

## 🔧 Requirements

- Docker installed (`sudo apt install docker.io`)
- Internet connection to pull Docker base images

---

## ✅ Step-by-Step Instructions

### 🔹 Step 1: Clone the Application Code

```bash
git clone https://github.com/Ibrahim-Adel15/Docker-1.git
cd Docker-1
```

### 🔹 Step 2: Create a Dockerfile

Create a file named `Dockerfile` and paste the following content:

```dockerfile
FROM maven:3.9.10-eclipse-temurin-17-alpine
WORKDIR /app
COPY . .
RUN mvn clean package
EXPOSE 8080
CMD ["java", "-jar", "target/demo-0.0.1-SNAPSHOT.jar"]
```

### 🔹 Step 3: Build the Docker Image

```bash
sudo docker build -t spring-demo-single .
```

the output like this:

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab11-run-java-sprint-boot-app-in-a-container-1-way/build%20container-1.png)
---

### 🔹 Step 4: Run the Container
```bash
sudo docker run -d -p 8080:8080 spring-demo-single
```
you can see the container and size from command :

```bash
sudo docker ps -a -s
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab11-run-java-sprint-boot-app-in-a-container-1-way/running%20container-1.png)

### 🔹 Step 5: Test the Application

Visit: `http://localhost:8080`
or
```bash
curl localhost:8080
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab11-run-java-sprint-boot-app-in-a-container-1-way/test%20container-1.png)
---

## 🧠 Notes

- This method is ideal for local development.
- The image size will be larger because it contains both Maven and JDK.
- For smaller images, consider multi-stage builds or building JAR externally.

## 👨‍💻 Author
Mohamed Magdy
🎓 DevOps Trainee @ iVolve

