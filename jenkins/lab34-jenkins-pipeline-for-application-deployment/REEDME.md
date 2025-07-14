# Jenkins CI/CD Pipeline for Java (Maven) App Deployment 🚀

This project demonstrates how to build a **CI/CD pipeline** using **Jenkins**, **Docker**, and **Kubernetes** for a Java Maven application.

---

## 📦 Project Structure

```
Jenkins_App/
├── Jenkinsfile                 # Pipeline definition
├── Dockerfile                  # Build app image
├── pom.xml                     # Maven project descriptor
├── src/                        # Java source code
└── k8s/
     └── deployment.yaml        # Kubernetes deployment definition
```


---

## 🛠️ Prerequisites

Make sure the following are installed and configured:

- [x] Java & Maven
- [x] Docker
- [x] Jenkins
- [x] Kubernetes cluster (e.g. Minikube or real cluster)
- [x] Docker Hub account

---

## 🚀 Pipeline Steps (What Jenkins does)

1. **Clone Repository** from GitHub.
2. **Run Unit Tests** using Maven: `mvn test`
3. **Build Application**: Compile and package the app: `mvn package`
4. **Build Docker Image** using `Dockerfile`.
5. **Push Docker Image** to Docker Hub.
6. **Delete Image Locally** (cleanup).
7. **Update Image in Kubernetes deployment.yaml**.
8. **Deploy to Kubernetes** using:  
   ```bash
   kubectl apply -f k8s/deployment.yaml
   ```

## ✅ Step-by-Step Guide

### 1️⃣ Clone the Repo

```bash
git clone https://github.com/Mohamedmagdy220/Jenkins_App.git
cd Jenkins_App
```

### 2️⃣ Add the Jenkinsfile

Make sure `Jenkinsfile` exists in the root directory (already included here).
and you can see my jenkins file by click here :

[jenkkinsfile](https://github.com/Mohamedmagdy220/Jenkins_App/blob/main/Jenkinsfile)

### 3️⃣ Setup Dockerfile

Ensure you have the `Dockerfile` ready to build the app using a JAR file. (already included).

### 4️⃣ Create Kubernetes deployment YAML

Check the file `k8s/deployment.yaml`. This is used to deploy the image to Kubernetes.

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab34-jenkins-pipeline-for-application-deployment/images/deployment%20file.png)
---

### 5️⃣ Setup Docker Hub Credentials in Jenkins

- Go to: Jenkins > Manage Jenkins > Credentials > Global > Add Credentials
- Select: **Username + Password**
- ID: `docker-hub-creds`
- Use your Docker Hub login

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab34-jenkins-pipeline-for-application-deployment/images/jenkins%20credentials.png)
---

### 6️⃣ Create a Jenkins Pipeline Job

- New Item → Type: **Pipeline**
- Select: **Pipeline from SCM**
- SCM: Git
- Repo: `https://github.com/Mohamedmagdy220/Jenkins_App.git`
- Script Path: `Jenkinsfile`

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab34-jenkins-pipeline-for-application-deployment/images/create%20pipeline%20in%20jenkins.png)
---

### 7️⃣ Run the Pipeline

Click **Build Now** and Jenkins will:

1. Run unit tests
2. Build app JAR
3. Build Docker image
4. Push image to Docker Hub
5. Clean local image
6. Update Kubernetes YAML
7. Deploy to cluster

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab34-jenkins-pipeline-for-application-deployment/images/success.png)
---
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab34-jenkins-pipeline-for-application-deployment/images/piplne%20success.png)
---

### 8️⃣ Check the Deployment

```bash
kubectl get pods
kubectl get deployments
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab34-jenkins-pipeline-for-application-deployment/images/get%20pods.png)
---
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab34-jenkins-pipeline-for-application-deployment/images/get%20deploy.png)
---
---

And you can see my image in docker hub by click here :

[my docker hub](https://hub.docker.com/repository/docker/mohamed2200/jenkins-app/general)

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab34-jenkins-pipeline-for-application-deployment/images/image%20in%20docker%20hub.png)
---

## 👤 Author

Mohamed Magdy  
DevOps & Cloud Enthusiast











