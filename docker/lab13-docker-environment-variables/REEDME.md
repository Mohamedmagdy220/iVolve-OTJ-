# 🐳 Lab 13: Docker Environment Variables

This lab demonstrates how to build a simple Python Flask application with Docker, and how to manage environment variables using multiple methods.

---

## 📦 Project Structure

```bash
Docker-3/
├── app.py
├── Dockerfile
├── .env.staging
└── README.md
```

## 🚀 Getting Started

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/Ibrahim-Adel15/Docker-3.git
cd Docker-3
```

### 2️⃣ Dockerfile Overview
We use a Python base image, install dependencies, expose a port, and configure environment variables.

```bash
# Dockerfile

FROM python:3.9
WORKDIR /app
COPY . .
RUN pip install flask
EXPOSE 8080

# Default environment variables (for production)
ENV APP_MODE=production
ENV APP_REGION=canada-west

CMD ["python", "app.py"]
```

### 3️⃣ Build the Docker Image
```bash
docker build -t env-app .
```

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab13-docker-environment-variables/list%20container.png)
---

### 🌐 Running the Container with Different Environments

#### 🔹 1. Development Mode (set in command)

```bash
docker run -p 8080:8080 \
-e APP_MODE=development \
-e APP_REGION=us-east \
env-app
```
Open your browser and go to:  
👉 `(http://127.0.0.1:8080
)`

you will see :
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab13-docker-environment-variables/run%20container%20with%20using%20Set%20variables%20in%20command.png)

or 

To inspect environment variables from inside a running container:

```bash
docker exec -it <container_id> printenv
```

--- 

#### 🔹 2. Staging Mode (set from '.env.staging' file)
Create the file:
```bash
# .env.staging
APP_MODE=staging
APP_REGION=us-west
```
Run the container using the file:

```bash
docker run -p 8080:8080 --env-file .env.staging env-app
```

Open your browser and go to:  
👉 `(http://127.0.0.1:8080
)`

you will see :
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab13-docker-environment-variables/run%20container%20with%20using%20Env%20Variables%20file.png)
---

#### 🔹 3. Production Mode (set inside Dockerfile)

```bash
docker run -p 8080:8080 env-app
```
Open your browser and go to:  
👉 `(http://127.0.0.1:8080
)`

you will see :
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab13-docker-environment-variables/run%20container%20with%20ENV%20Varibles%20set%20in%20docker%20file.png)
---

## 🛠️ Notes

- Flask runs on port 8080. Make sure it's free.
- This app displays environment variables as part of the homepage.
- You can extend this app with more routes, configs, and secrets as needed.

## 👨‍💻 Author

### Mohamed Magdy 
### 🎓 DevOps Trainee @ iVolve
