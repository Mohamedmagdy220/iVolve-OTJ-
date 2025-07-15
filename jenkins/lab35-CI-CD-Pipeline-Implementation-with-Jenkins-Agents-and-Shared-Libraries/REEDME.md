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
### 🔹 Step 2: Setup Agent vm:

#### 1- install Prerequisites on the Agent VM:
Make sure the VM (agent) has:

- [x] Java installed (java -version must work)
  you can install it with yhis command:
  ```bash
   sudo yum install java
  ```
- [x] Network access to the Jenkins controller (in this repo : port 22 for SSH)
- [x] SSH access (if using SSH connection) 

#### 2- Generate an SSH Key 
generate new keys in Jenkins Master VM:
```bash
ssh-keygen -t rsa -b 2048 -f ~/.ssh/jenkins_agent_key
```
You’ll get in `~/.ssh/`:
```
jenkins_agent_key (private key)
jenkins_agent_key.pub (public key)
```
sent public key into the Agent VM:
```bash
ssh-copy-id -i ~/.ssh/jenkins_agent_key.pub magdy@192.168.80.128
```
test the ssh connectivity:
```bash
ssh -i ~/.ssh/jenkins_agent_key magdy@192.168.80.128
```
#### 3- Create Agent root home directory
On Agent VM
```bash
sudo mkdir /home/jenkins_home
sudo chmod 777 /home/jenkins_home
```

### 4- Add SSH credentials in Jenkins

- Go to: `Manage Jenkins > Credentials > Global`
- Add: `SSH Username with private key`
- Username: `magdy`
- Private key: `Paste content of private key`

### 5- Setup DockerHub Credentials in Jenkins 
- Go to: `Manage Jenkins > Credentials > Global`
- Add: `Username with password`
- ID: `docker-hub-creds`
  
![credentials](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab35-CI-CD-Pipeline-Implementation-with-Jenkins-Agents-and-Shared-Libraries/images/two%20credentials%20.png)
---
### 6- Setup Jenkins Agent
- Go to `Manage Jenkins > Nodes > New Node`
- Create a Permanent Agent:
  - Name: `agent-vm-1`
  - Remote root: `/home/jenkins-home`
  - Labels: `worker-1`
  - Use SSH to connect
- Add SSH credentials

![agent-node](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab35-CI-CD-Pipeline-Implementation-with-Jenkins-Agents-and-Shared-Libraries/images/nodes%20in%20jenkins.png)
---
#### 7- Test Connection:
Make sure the agent is online from the logs

![agent-node](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab35-CI-CD-Pipeline-Implementation-with-Jenkins-Agents-and-Shared-Libraries/images/online%20agent.png)
---


### 8- Install required packages on Agent
```bash
sudo apt update && sudo apt install git docker.io maven -y
sudo usermod -aG docker <agent-user>
sudo reboot
```
and you must have `kubectl` on agent you can install it with this command:
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client
```

### 🔹 Step 3: Create Shared Library Repo Structure
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
and the files contain:

#### 🧪 runUnitTest.groovy
```groovy
def call() {
    echo "Running unit tests..."
    sh "pytest tests/" 
}
```

#### ⚙️ buildApp.groovy

```groovy
def call() {
    echo "Building application..."
    sh "python setup.py build"  
}
```
#### 🐳 buildImage.groovy

```groovy
def call() {
    echo "Building Docker image..."
    sh "docker build -t your-image-name:latest ."
}
```
#### 🔍 scanImage.groovy
```groovy
def call() {
    echo "Scanning Docker image..."
    sh "trivy image your-image-name:latest"  
}
```

#### ☁️ pushImage.groovy
```groovy
def call() {
    echo "Pushing Docker image..."
    sh "docker push your-image-name:latest"
}
```
#### 🧹 removeImageLocally.groovy
```groovy
def call() {
    echo "Removing local Docker image..."
    sh "docker rmi your-image-name:latest"
}
```

#### 🚀 deployOnK8s.groovy
```groovy
def call() {
    echo "Deploying on Kubernetes..."
    sh "kubectl apply -f k8s/deployment.yaml"
}
```

and you can clone it from :
```bash
git clone https://github.com/Mohamedmagdy220/jenkins-shared-lib.git
cd vars
```
---
### 🔹 Step 4: Register Shared Library in Jenkins
- GO to `Manage Jenkins > Configure System > Global Pipeline Libraries`
- Name: `my-lib`
- SCM: `Git`
- Repo URL: `your-shared-library-repo`

![library in jenkins](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab35-CI-CD-Pipeline-Implementation-with-Jenkins-Agents-and-Shared-Libraries/images/configuration%20of%20library%20in%20jenkins.png)
---
### 🔹 Step 5: Jenkinsfile in Project Root
Make sure `Jenkinsfile` exists in the root directory (already included here).
```
@Library('my-lib') _  

pipeline {
    agent { label 'worker-1' }

environment {
    IMAGE_NAME = 'mohamed2200/jenkins-app'
    IMAGE_TAG  = 'latest'
    }

    stages {
        stage('Run Unit Tests') {
            steps { runUnitTest() }
        }
        stage('Build Application') {
            steps { buildApp() }
        }
        stage('Build Docker Image') {
            steps { buildImage() }
        }
        stage('Scan Docker Image') {
            steps { scanImage() }
        }
        stage('Push Docker Image') {
            steps { pushImage() }
        }
        stage('Remove Local Image') {
            steps { removeImageLocally() }
        }
        stage('Deploy on K8s') {
            steps { deployOnK8s() }
        }
    }
}
```
---

### 🔹 Step 6: Dockerfile
Ensure you have the `Dockerfile` ready to build the app using a JAR file. (already included).

```
FROM maven:sapmachine 

# Set working directory in container
WORKDIR /app

# Copy JAR file
COPY target/demo-0.0.1-SNAPSHOT.jar .

# Run the application
CMD ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]

EXPOSE 8080
```
---


### 🔹 Step 7: Kubernetes Deployment YAML (`k8s/deployment.yaml`)

Check the file `k8s/deployment.yaml`. This is used to deploy the image to Kubernetes.

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab34-jenkins-pipeline-for-application-deployment/images/deployment%20file.png)
---

✅ After completing all steps, run the pipeline from Jenkins and watch each stage execute!

### 🔹 Step 8: Create a Jenkins Pipeline Job

- New Item → Type: **Pipeline**
- Select: **Pipeline from SCM**
- SCM: Git
- Repo: `https://github.com/Mohamedmagdy220/Jenkins_App2.git`
- Script Path: `Jenkinsfile`

![create pipeline](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab35-CI-CD-Pipeline-Implementation-with-Jenkins-Agents-and-Shared-Libraries/images/view%20pipelines.png)
---

### 🔹 Step 9: Run the Pipeline

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

### 🔹 Step 10: Check the Deployment

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


