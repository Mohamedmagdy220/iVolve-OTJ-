# Build Java Application using Apache Maven

This lab walks you through building a **Java 17+ application** using **Apache Maven** on a CentOS-based Linux system.  
You’ll learn to install Maven, clone a Maven-based Java project, run unit tests, build the application, and verify its output.

---

## 📋 Prerequisites

Ensure the following are available on your system:

- ✅ compatible Linux
- ✅ Java 17 or later
- ✅ Apache Maven (`mvn`)
- ✅ `git` installed

---

## 🛠️ Step 1: Install Apache Maven

```bash
sudo apt install maven -y
```
---
### ✅ Verify Maven Installation

```bash
mvn -v
```

### Expected output:

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/build-tools/Build%20Java%20App%20using%20maven%20/images/maven%20version.png)
---

## 📥 Step 2: Clone the Application Repository

```bash
git clone https://github.com/Ibrahim-Adel15/build2.git
cd build2
```

## ✅ Step 3: Run Unit Tests

```bash
mvn test
```

### Successful output should show:

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/build-tools/Build%20Java%20App%20using%20maven%20/images/maven%20test.png)
---

## 🏗️ Step 4: Build the Application

```bash
mvn package
```

### Maven will generate a JAR file at:

```bash
target/hello-ivolve-1.0-SNAPSHOT.jar
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/build-tools/Build%20Java%20App%20using%20maven%20/images/maven%20build.png)
---

## ▶️ Step 5: Run the Application

```bash
java -jar target/hello-ivolve-1.0-SNAPSHOT.jar
```

### Expected output in the terminal:

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/build-tools/Build%20Java%20App%20using%20maven%20/images/maven%20run.png)
---

## 👨‍💻 Author
Mohamed Magdy
🎓 DevOps Trainee @ iVolve

