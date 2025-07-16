
# Lab 36: Multi-Branch CI/CD Workflow with Jenkins, Kubernetes & Shared Library

This guide explains how to set up a complete CI/CD pipeline using **Jenkins**, **DockerHub**, **Kubernetes**, and a **Jenkins Shared Library**. It supports multiple branches (`main`, `stag`, `dev`) and deploys to corresponding Kubernetes namespaces.

---
## 📦 Project Overview

This Java Maven project contains:

- `src/`: Java source code
- `pom.xml`: Maven build file
- `Dockerfile`: to build a container image for the application
- `k8s/deployment.yaml`: Kubernetes deployment manifest
- `Jenkinsfile`: declarative pipeline definition

---

## ✅ Prerequisites

- Installed Jenkins (with Docker and kubectl access)
- Kubernetes cluster (Minikube or real cluster)
- DockerHub account
- GitHub account

---

## 🧱 Folder Structure (Main App Repo)

```css
Jenkins_App/
├── Dockerfile
├── pom.xml
├── src/
├── Jenkinsfile     
└── k8s/
    └── deployment.yaml  
jenkins-shared-lib/
└── vars/
    ├── buildApp.groovy
    ├── buildImage.groovy
    ├── pushImage.groovy
    └── deploy.groovy
```
---

## first of all (optional >> if you nead agent to run pipe line )

### 🔹 Setup Agent vm:

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

## ✅ Step-by-Step Instructions

## 🟢 Step 1: Clone & Prepare the Main Repo

```bash
git clone https://github.com/Moahmedmagdy220/Jenkins_App2.git
cd Jenkins_App
```

Create your own repo (e.g., `Jenkins_MultiBranch`) and push the code:

```bash
git remote rename origin old
git remote add origin https://github.com/YOUR_USERNAME/Jenkins_MultiBranch.git
```

Then create branches:

```bash
git checkout -b main && git push -u origin main
git checkout -b stag && git push -u origin stag
git checkout -b dev && git push -u origin dev
```
after create branches you will see this in your repo:
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab36-multi-branch-ci-cd-workflow/images/3%20branch%20in%20github.png)
---

## 🟡 Step 2: Create Kubernetes Namespaces

```bash
kubectl create namespace main
kubectl create namespace stag
kubectl create namespace dev
```

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab36-multi-branch-ci-cd-workflow/images/get%20namespaces.png)
---

## 🔵 Step 3: Create Shared Library Repo

Create a new GitHub repo named `jenkins-shared-library2` and add the following structure:

```
jenkins-shared-lib/
└── vars/
    ├── buildApp.groovy
    ├── buildImage.groovy
    ├── pushImage.groovy
    └── deploy.groovy
```

### `buildApp.groovy`

```groovy
def call() {
    sh 'mvn clean install'
}
```

### `buildImage.groovy`

```groovy
def call(String imageName) {
    sh "docker build -t ${imageName} ."
}
```

### `pushImage.groovy`

```groovy
def call(String imageName) {
    withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        sh "echo $PASSWORD | docker login -u $USERNAME --password-stdin"
        sh "docker push ${imageName}"
    }
}
```

### `deploy.groovy`

```groovy
def call(String namespace) {
    sh "kubectl apply -f k8s/k8s_deployment.yaml -n ${namespace}"
}
```

---

## 🟣 Step 4: Add Shared Library to Jenkins

1. Go to `Manage Jenkins` → `Configure System`
2. Scroll to `Global Pipeline Libraries` and add a new one:
   - **Name**: `my-shared-lib`
   - **Default version**: `main`
   - **Project Repository**: `https://github.com/YOUR_USERNAME/jenkins-shared-lib.git`
   - **SCM**: Git

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab36-multi-branch-ci-cd-workflow/images/my%20shared%20lib.png)
---

## 🟠 Step 5: Create Jenkins Credentials for DockerHub

1. Go to `Manage Jenkins` → `Credentials` → Global → `Add Credentials`
2. Select:
   - Kind: `Username with password`
   - ID: `dockerhub-creds`
   - Username: _your DockerHub username_
   - Password: _your DockerHub password_

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab36-multi-branch-ci-cd-workflow/images/docker-hub-credentials.png)
---

## 🟤 Step 6: Write `Jenkinsfile` in Each Branch

Put this `Jenkinsfile` in all 3 branches:

```groovy
@Library('my-shared-lib-lab35') _     ###<<<the name of library

pipeline {
    agent { label 'worker-1' }   ###<<<your agent

    environment {
        IMAGE = "mohamed2200/jenkins-app:${env.BRANCH_NAME}"
        NAMESPACE = "${env.BRANCH_NAME}"
    }

    stages {
        stage('Build') {
            steps {
                buildApp()
            }
        }

        stage('Build Docker Image') {
            steps {
                buildImage(IMAGE)
            }
        }

        stage('Push Docker Image') {
            steps {
                pushImage(IMAGE)
            }
        }

        stage('Deploy to K8s') {
            steps {
                deploy(NAMESPACE)
            }
        }
    }
}
```

---

## 🔴 Step 7: Create Multibranch Pipeline in Jenkins

1. Click `New Item` → Name: `Jenkins_MultiBranch` → Select `Multibranch Pipeline`
2. In `Branch Sources`:
   - Add source → Git
   - Repo URL: `https://github.com/YOUR_USERNAME/Jenkins_MultiBranch.git`
3. Under `Build Configuration`:
   - Mode: `by Jenkinsfile`
   - Script Path: `Jenkinsfile`
4. Save

after success you can see your pipeline here like that :

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab36-multi-branch-ci-cd-workflow/images/create%20multibranch%20pipeline.png)
---

and after scan :

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab36-multi-branch-ci-cd-workflow/images/scan%20multibranch%20success.png)
---

and you can see the three branches was detacted :

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab36-multi-branch-ci-cd-workflow/images/branches%20in%20multibranch%20pipeline.png)
---

## ✅ Final step

- Push to `main`, `stag`, or `dev`
- Jenkins will build the app, build the image, push to DockerHub, and deploy to the appropriate K8s namespace.

the Branch `main` :

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab36-multi-branch-ci-cd-workflow/images/console%20output%20in%20main%20branch.png)
---
the Branch `dev` :

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab36-multi-branch-ci-cd-workflow/images/console%20output%20in%20dev%20branch.png)
---
the Branch `stag` :

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab36-multi-branch-ci-cd-workflow/images/console%20output%20in%20stag%20branch.png)
---

## ✅ Final test

you can run in your terminal these commands to see that :
```bash
kubectl get pods
kubectl get deployments
kubectl get rs
```

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab36-multi-branch-ci-cd-workflow/images/get%20pods.png)
---
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab36-multi-branch-ci-cd-workflow/images/get%20deploy.png)
---
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab36-multi-branch-ci-cd-workflow/images/get%20replicaset.png)
---

And you can see my image in docker hub by click here :
[my docker hub](https://hub.docker.com/repository/docker/mohamed2200/jenkins-app/general)

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/jenkins/lab36-multi-branch-ci-cd-workflow/images/image%20in%20docker%20hub.png)
---

🎉 **You're Done!**


## 👤 Author

Mohamed Magdy  
DevOps & Cloud Enthusiast
