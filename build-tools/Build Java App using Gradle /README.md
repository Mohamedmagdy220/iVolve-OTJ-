# 🚀 Java Application Build with Gradle

This lab demonstrates how to build and run a simple Java application using **Gradle** on **CentOS 8/9 Stream** (or any equivalent Linux distribution).  
You’ll install Java 17 and Gradle 8.7, clone the source code, run unit tests, build a JAR, and run the app.

---

## 📋 Prerequisites

Before starting, ensure the following are installed:

- ✅ CentOS 8 Stream or CentOS 9 Stream (or compatible Linux distro)
- ✅ `java-17-openjdk` & `java-17-openjdk-devel`
- ✅ `git`
- ✅ `wget` & `unzip`

---

## 🛠️ Step 1: Install Java & Gradle

### Install Java 17

```bash
sudo apt install openjdk-17-jdk -y
```
### Install Gradle 8.7

```bash
sudo apt install wget unzip -y
wget https://services.gradle.org/distributions/gradle-8.7-bin.zip -P /tmp
sudo mkdir /opt/gradle
sudo unzip -d /opt/gradle /tmp/gradle-8.7-bin.zip
sudo ln -s /opt/gradle/gradle-8.7 /opt/gradle/latest
```

### Configure Gradle Environment

```bash
echo 'export GRADLE_HOME=/opt/gradle/latest' | sudo tee /etc/profile.d/gradle.sh
echo 'export PATH=${GRADLE_HOME}/bin:${PATH}' | sudo tee -a /etc/profile.d/gradle.sh
sudo chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
```

### Verify Installation

```bash
gradle -v
```

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/build-tools/Build%20Java%20App%20using%20Gradle%20/images/gradle%20version.png)
---

## 📦 Step 2: Clone the Application Repository

```bash
git clone https://github.com/ibrahim-Adel15/build1.git
cd build1
```
## ✅ Step 3: Run Unit Tests

```bash
gradle test
```
### Check the test output to ensure all tests pass like this :

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/build-tools/Build%20Java%20App%20using%20Gradle%20/images/gradle%20test.png)
---

## 🧱 Step 4: Build the Application

```bash
gradle build
```

### The build will generate a JAR file located at:

```bash
build/libs/ivolve-app.jar
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/build-tools/Build%20Java%20App%20using%20Gradle%20/images/gradle%20build.png)
---

## ▶️ Step 5: Run the Application

```bash
java -jar build/libs/ivolve-app.jar
```
### Expected console output:

```bash
Hello iVolve Trainee
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/build-tools/Build%20Java%20App%20using%20Gradle%20/images/gradle%20run.png)
---

## 💡 Notes

- You can change Gradle versions by updating the download link and symbolic link in /opt/gradle.
- This app is a minimal demo and can be extended with Spring Boot, REST APIs, etc.

## 👨‍💻 Author
Mohamed Magdy
🎓 DevOps Trainee at iVolve
