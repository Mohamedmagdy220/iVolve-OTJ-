# 🚀 Spring Boot Docker App – Multi-Stage Docker Build (Maven + Java 17)

This guide shows how to build and run a Spring Boot application using **multi-stage Docker builds**. It ensures small image size and clean production-ready deployment.

---

## 📌 Project Overview

Multi-stage builds allow you to:

- Use a Maven container to build your app.
- Copy only the final `.jar` into a lightweight Java runtime container.
- Keep your image small and secure by excluding unnecessary build tools.

---

## 🔧 Requirements

- Docker installed (`sudo apt install docker.io`)
- Internet connection to pull Docker base images
- No need for Java/Maven installed locally (optional if testing outside Docker)

---

## 📂 Project Structure

```
project-root/
├── src/
├── pom.xml
├── Dockerfile
└── target/
    └── demo-0.0.1-SNAPSHOT.jar (generated inside Docker)
```

> Maven compiles the source and produces the `.jar` during the Docker build process.

---

## ✅ Step-by-Step Instructions

### 🔹 Step 1: Clone the Application Code

```bash
git clone https://github.com/Ibrahim-Adel15/Docker-1.git
cd Docker-1
```

---

### 🔹 Step 2: Create the Dockerfile

Create a file named `Dockerfile` in the root folder:

```dockerfile
FROM maven:3.8.5-openjdk-17-slim AS builder
WORKDIR /app
COPY . .
RUN mvn clean package

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/demo-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```

---

### 🔹 Step 3: Build the Docker Image

```bash
sudo docker build -t spring-demo-multi .
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab12-multi-stage-build-for-a-nodejs-app/build%20container-3.png)
---

### 🔹 Step 4: Run the Docker Container

```bash
sudo docker run -d -p 8080:8080 spring-demo-multi
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab12-multi-stage-build-for-a-nodejs-app/multi-stage%20container.png)
---

### 🔹 Step 5: Access the Application

Open your browser and go to:  
👉 `http://localhost:8080`

or 

```bash
curl localhost:8080
```

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab12-multi-stage-build-for-a-nodejs-app/test%20multi-stage%20container.png)
---

## 🧠 Notes

- This method ensures **smaller image size** and better separation of concerns.
- Ideal for **production** and **CI/CD** environments.
- Build tools like Maven are NOT included in the final image.

---

## ✅ When to Use This Method

| Ideal for...             | Not ideal for...          |
|--------------------------|----------------------------|
| Production deployments   | Fast local testing         |
| CI/CD pipelines          | Rebuilding image frequently |
| Clean, small images      | Debugging during build     |

---

👨‍💻 Author
Mohamed Magdy 🎓 DevOps Trainee @ iVolve

