# Node.js with MySQL Docker Compose Application

## Overview
This project sets up a containerized Node.js application with a MySQL database using Docker Compose. The application requires a MySQL database named ivolv to function properly.

## Prerequisites
- Docker installed
- Docker Compose installed
- Git installed

## Project Structure

```bash
kubernets-app/
├── docker-compose.yml
├── Dockerfile
├── src/
│   ├── app.js
│   └── ... (other application files)
├── logs/
└── README.md
```


## Getting Started
### 1. Clone the repository

```bash
git clone https://github.com/lbrahim-Adel15/kubernets-app.git
cd kubernets-app
```

### 2. Create docker-compose.yml file

Create a file named docker-compose.yml with the following content:
```bash
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DB_HOST=${DB_HOST}
      - DB_USER=${DB_USER}
      - DB_PASSWORD=${DB_PASSWORD}
    depends_on:
      - db

  db:
    image: mysql
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
      - MYSQL_DATABASE=${MYSQL_DATABASE} 
    volumes:
      - db_data:/var/lib/mysql
volumes:
  db_data:
```

### 3. Build and run the containers

```bash
docker-compose up --build
```
you will see this :

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab18-containerized-nodejs-and-mysql/after%20docker%20compose.png)
---

### 4. Verify the application

#### 1 >>> Application status

```bash
curl http://localhost:3000
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab18-containerized-nodejs-and-mysql/access%20db.png)
---

#### 2 >>> Health check:

```bash
curl http://localhost:3000/health   # ➜ OK
```

#### 3 >>> Readiness check:

```bash
http://localhost:3000/ready       # ➜ Ready 
```

#### 4 >>> Access logs:

```bash
docker compose logs app
```

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab18-containerized-nodejs-and-mysql/get%20logs%20for%20app.png)
---

### 5. Push the Docker image to DockerHub
 
First, log in to DockerHub:

```bash
docker login
```

Then tag and push your image (replace yourusername with your DockerHub username):

```bash
docker tag kubernets-app_app yourusername/node-mysql-app
docker push yourusername/node-mysql-app
```


## Cleanup

To stop and remove all containers and volumes:
```bash
docker-compose down -v
```










