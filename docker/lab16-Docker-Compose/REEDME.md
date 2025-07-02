# 📦 Node.js + PostgreSQL App with Docker Compose
This project demonstrates how to containerize a Node.js application with a PostgreSQL database using Docker Compose.
It includes a shared network and persistent volume for the database.

## 📁 Project Structure

```bash
docker6
├── Dockerfile
├── docker-compose.yml
├── .env
├── app/             # Node.js application source
└── README.md
```

## 🚀 Getting Started
### 1. 🔁 Clone the Repository

```bash
git clone https://github.com/Ibrahim-Adel15/docker6.git
cd docker6
```

### 2. 🛠 Configure Environment Variables

Create a `.env` file in the root directory with the following content:
```bash
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=postgres
```
### 3. 🛠 create docker compose file 

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab16-Docker-Compose/docker%20compose%20file.png)
---

### 4. 🐳 Build and Run the App

```bash
docker-compose up --build -d
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab16-Docker-Compose/docker%20compose%20up.png)
---
#### list my networks
```bash
docker network ls
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab16-Docker-Compose/networks.png)
---

#### list my volumes
```bash
docker volume ls
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab16-Docker-Compose/volume.png)
---

### 5. 🐳 test connection

```bash
curl localhost:3000
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab16-Docker-Compose/test.png)
---


## 🧹 Clean Up

### To stop containers:

```bash
docker-compose down
```

### To stop and remove all containers, networks, and volumes:

```bash
docker-compose down -v
```

## 📎 Notes

- Make sure Docker and Docker Compose are installed on your machine.
- Default credentials and settings are for development purposes only.
- You can customize ports, database name, etc. via the .env file.

## 👨‍💻 Author
Made with ❤️ by [Mohamed magdy]



