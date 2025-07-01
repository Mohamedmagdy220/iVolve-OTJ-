# Lab 15: Custom Docker Network for Microservices

This project demonstrates how to containerize two microservices (frontend and backend) using Docker, and connect them using a custom Docker network.

---

## 📁 Project Structure

```bash
Docker5/
│
├── frontend/
│ ├── app.py
│ ├── requirements.txt
│ └── Dockerfile
│
├── backend/
│ ├── app.py
│ └── Dockerfile
```


---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Ibrahim-Adel15/Docker5.git
cd Docker5
```
### 🐳 Dockerfile for Frontend
#### create Dockerfile inside frontend/ directory:

```bash
FROM python:3.9

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
```

### 🐳 Dockerfile for Backend
#### Create Dockerfile inside backend/ directory:

```bash
FROM python:3.9

WORKDIR /app

RUN pip install flask

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
```

### 🐳 Docker Setup
### 2. Build Docker Images

Build Backend Image
```bash
docker build -t backend-image ./backend
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab15-Custom-Docker-Network-for-Microservices/build%20image%20backend.png)
---
Build Frontend Image
```bash
docker build -t frontend-image ./frontend
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab15-Custom-Docker-Network-for-Microservices/build%20image%20frontend.png)
---
### 3. Create Custom Docker Network

```bash
docker network create ivolve-network
```

### 4. Run Containers
Run Backend on `ivolve-network`

```bash
docker run -d --name backend --network ivolve-network backend-image
```
Run Frontend1 on `ivolve-network`

```bash
docker run -d --name frontend1 --network ivolve-network frontend-image
```

Run Frontend2 on Default Network (bridge)
```bash
docker run -d --name frontend2  -p 5001:5000 frontend-image
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab15-Custom-Docker-Network-for-Microservices/list%20containers.png)
---


### 5. Verify Communication

ping from the frontend1 container:

```bash
docker exec -it frontend1 sh
ping backend
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab15-Custom-Docker-Network-for-Microservices/test%20connection%20(frontend1%2Cbackend).png)
---

ping from the frontend2 container:

```bash
docker exec -it frontend2 sh
ping backend
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/docker/lab15-Custom-Docker-Network-for-Microservices/test%20connection%20(frontend2%2Cbackend).png)
---

You should see replies if they are on the same network.
Frontend2 cannot communicate with backend because it’s on the default bridge network.

### 6. Clean Up

```bash
docker rm -f frontend1 frontend2 backend
docker network rm ivolve-network
```

## 👨‍💻 Author
Made with ❤️ by [Mohamed magdy]



