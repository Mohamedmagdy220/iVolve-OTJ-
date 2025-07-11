# Lab 17: Scan Docker Image with Trivy

This lab demonstrates how to containerize a Java Spring Boot application using Docker, then scan the image for vulnerabilities using **Trivy**, and finally push the image to **DockerHub**.

---

## 🔧 Prerequisites

- Docker installed
- Git installed
- Trivy installed ([Installation Guide](https://trivy.dev/latest/getting-started/installation/))
- DockerHub account

---
## 🚀 Getting Started
### 📦 Step 1: Clone the Project Repository

```bash
git clone https://github.com/Ibrahim-Adel15/Docker-1.git
cd Docker-1
```


### 📝 Step 2: Create Dockerfile
### Here is the complete Dockerfile used in this project:

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab17-Scan-docker-image-with-trivy/docker%20file.png)
---

### 🛠️ Step 3: Build Docker Image

```bash
docker build -t my-app:latest .
```
#### After a successful build, you should see:

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab17-Scan-docker-image-with-trivy/list%20images.png)
---

### 🔍 Step 4: Scan Image with Trivy

```bash
trivy image --format json -o trivy-report.json my-app:latest

```

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab17-Scan-docker-image-with-trivy/scan%20image%20with%20trivy.png)
---

### 📁 Step 5: Verify JSON Report

#### After a successful scan, you should see:

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab17-Scan-docker-image-with-trivy/trivy%20report%20json.png)
---

### ☁️ Step 6: Push Image to DockerHub

#### 1. Login to DockerHub:
```bash
docker login
```
#### 2. Tag the image with your DockerHub username:

```bash
docker tag my-app:latest yourusername/my-app:latest
```
#### 3. Push the image:
```bash
docker push yourusername/my-app:latest
```

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab17-Scan-docker-image-with-trivy/docker%20hub.png)
---

## 📚 Resources

- Trivy Documentation: https://trivy.dev
- DockerHub: https://hub.docker.com/repository/docker/mohamed2200/my-app/general
- Project Code: https://github.com/Ibrahim-Adel15/Docker-1

## 👨‍💻 Author
Made with ❤️ by [Mohamed magdy]
