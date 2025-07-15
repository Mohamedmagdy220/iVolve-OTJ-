# 🔧 Lab 35: CI/CD Pipeline Implementation with Jenkins Agents and Shared Libraries

This project demonstrates a full CI/CD pipeline using **Jenkins**, **Docker**, **Kubernetes**, **Jenkins Shared Libraries**, and **SSH agents**.

---

## 📦 Project Overview

This Java Maven project contains:

- `src/`: Java source code
- `pom.xml`: Maven build file
- `Dockerfile`: to build a container image for the application
- `k8s/deployment.yaml`: Kubernetes deployment manifest
- `Jenkinsfile`: declarative pipeline definition

---

## ✅ Objectives

- Clone code from GitHub
- Run Unit Tests
- Build Java Application with Maven
- Build Docker Image
- Scan Docker Image for vulnerabilities
- Push Image to DockerHub
- Remove Local Image to save space
- Deploy to Kubernetes cluster
- Use Jenkins Agents to run the pipeline
- Implement Shared Library for reusability

---

## 🖥️ System Requirements

- Jenkins Master installed
- Jenkins Agent (SSH-connected) configured and running
- Jenkins Plugins:
  - Pipeline
  - Git
  - Docker
  - Kubernetes CLI
  - Trivy (optional, for image scanning)
- Docker installed on Jenkins Agent
- Kubernetes cluster access (`kubectl` + `~/.kube/config` configured)
- Git & Maven installed on Jenkins Agent

---

## 🧱 File Structure
```css
Jenkins_App/
├── Dockerfile
├── pom.xml
├── src/
├── Jenkinsfile     
└── k8s/
    └── deployment.yaml  
jenkins-shared-library/
└── vars/
    ├── runUnitTest.groovy
    ├── buildApp.groovy
    ├── buildImage.groovy
    ├── scanImage.groovy
    ├── pushImage.groovy
    ├── removeImageLocally.groovy
    └── deployOnK8s.groovy
```

## ✅ Step-by-Step Instructions

### 🔹 Step 1: Clone the Project
```bash
git clone https://github.com/Moahmedmagdy220/Jenkins_App2.git
cd Jenkins_App
```
### 🔹 Step 2: Add SSH credentials in Jenkins

- Go to: `Manage Jenkins > Credentials > Global`
- Add: `SSH Username with private key`
- Username: `magdy`
- Private key: `Paste content of private key`

### 🔹 Step 3: Setup DockerHub Credentials in Jenkins
- Go to: `Manage Jenkins > Credentials > Global`
- Add: `Username with password`
- ID: `docker-hub-creds`
  
![credentials](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab35-CI-CD-Pipeline-Implementation-with-Jenkins-Agents-and-Shared-Libraries/images/two%20credentials%20.png)
---
### 🔹 Step 4: Setup Jenkins Agent
- Go to `Manage Jenkins > Nodes > New Node`
- Create a Permanent Agent:
  - Name: `agent-vm-1`
  - Remote root: `/home/jenkins-home`
  - Labels: `worker-1`
  - Use SSH to connect
- Add SSH credentials

![agent-node](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab35-CI-CD-Pipeline-Implementation-with-Jenkins-Agents-and-Shared-Libraries/images/online%20agent.png)
---
![agent-node](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab35-CI-CD-Pipeline-Implementation-with-Jenkins-Agents-and-Shared-Libraries/images/nodes%20in%20jenkins.png)
---

### 🔹 Step 5: Install Requirements on Agent
```bash
sudo apt update && sudo apt install git docker.io maven -y
sudo usermod -aG docker <agent-user>
sudo reboot
```

### 🔹 Step 6: Create Shared Library Repo Structure
```bash
mkdir -p jenkins-shared-library/vars
# Add the following .groovy files under vars/
```
```
jenkins-shared-library/
└── vars/
    ├── runUnitTest.groovy
    ├── buildApp.groovy
    ├── buildImage.groovy
    ├── scanImage.groovy
    ├── pushImage.groovy
    ├── removeImageLocally.groovy
    └── deployOnK8s.groovy
```
as shown earlier.
and you can see my files by click here :
[library files](https://github.com/Mohamedmagdy220/jenkins-shared-lib/tree/main/vars)
---
and you can clone it from :
```bash
git clone https://github.com/Mohamedmagdy220/jenkins-shared-lib.git
cd vars
```
---
### 🔹 Step 7: Register Shared Library in Jenkins
- GO to `Manage Jenkins > Configure System > Global Pipeline Libraries`
- Name: `my-lib`
- SCM: `Git`
- Repo URL: `your-shared-library-repo`

![library in jenkins](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab35-CI-CD-Pipeline-Implementation-with-Jenkins-Agents-and-Shared-Libraries/images/configuration%20of%20library%20in%20jenkins.png)
---
### 🔹 Step 8: Jenkinsfile in Project Root
Make sure `Jenkinsfile` exists in the root directory (already included here).
and you can see my jenkins file by click here :

[jenkkinsfile](https://github.com/Mohamedmagdy220/Jenkins_App2/blob/main/Jenkinsfile)
---

### 🔹 Step 9: Dockerfile
Ensure you have the `Dockerfile` ready to build the app using a JAR file. (already included).

[dockerfile](https://github.com/Mohamedmagdy220/Jenkins_App2/blob/main/Dockerfile)
---


### 🔹 Step 10: Kubernetes Deployment YAML (`k8s/deployment.yaml`)

Check the file `k8s/deployment.yaml`. This is used to deploy the image to Kubernetes.

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab34-jenkins-pipeline-for-application-deployment/images/deployment%20file.png)
---

✅ After completing all steps, run the pipeline from Jenkins and watch each stage execute!

### 6️⃣ Create a Jenkins Pipeline Job

- New Item → Type: **Pipeline**
- Select: **Pipeline from SCM**
- SCM: Git
- Repo: `https://github.com/Mohamedmagdy220/Jenkins_App2.git`
- Script Path: `Jenkinsfile`

![create pipeline](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab35-CI-CD-Pipeline-Implementation-with-Jenkins-Agents-and-Shared-Libraries/images/view%20pipelines.png)
---

### 7️⃣ Run the Pipeline

Click **Build Now** and Jenkins will:

1. Run unit tests
2. Build app JAR
3. Build Docker image
4. Scan image
5. Push image to Docker Hub
6. Clean local image
7. Deploy to cluster

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab35-CI-CD-Pipeline-Implementation-with-Jenkins-Agents-and-Shared-Libraries/images/running%20pipeline%20with%20agent.png)
---
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab35-CI-CD-Pipeline-Implementation-with-Jenkins-Agents-and-Shared-Libraries/images/pipeline%20success.png)
---

### 8️⃣ Check the Deployment

```bash
kubectl get pods
kubectl get deployments
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab34-jenkins-pipeline-for-application-deployment/images/get%20deploy.png)
---
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab34-jenkins-pipeline-for-application-deployment/images/get%20pods.png)
---
---

And you can see my image in docker hub by click here :

[my docker hub](https://hub.docker.com/repository/docker/mohamed2200/jenkins-app/general)

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab35-CI-CD-Pipeline-Implementation-with-Jenkins-Agents-and-Shared-Libraries/images/docker%20hub.png)
---

## 👤 Author

Mohamed Magdy  
DevOps & Cloud Enthusiast


