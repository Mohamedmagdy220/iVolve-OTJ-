# Kubernetes ConfigMaps and Secrets Management

![Kubernetes Logo](https://kubernetes.io/images/favicon.png)

## 📌 Overview
This project demonstrates secure configuration management in Kubernetes using ConfigMaps for non-sensitive data and Secrets for sensitive information, following Kubernetes best practices.

## 🚀 Quick Start

### 1. Create ConfigMap file 

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab21-configmabs-and-secerts/configmap%20file.png)
---

### 2. Create Secret

First create values by `base64`
```bash
echo -n 'securepassword' | base64  # لـ DB_PASSWORD
echo -n 'rootpass123' | base64    # لـ MySQL_ROOT_PASSWORD
```

Then create secret file 
Secret (mysql-secret.yaml)

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab21-configmabs-and-secerts/secret%20file.png)
---




