# MySQL Deployment Using StatefulSet on Kubernetes

This project demonstrates how to deploy MySQL using a StatefulSet on a Kubernetes cluster with:

- Local StorageClass
- Persistent Volume and Claim
- Kubernetes Secret for password management
- Headless Service for stable network identity
- Resource limits to prevent memory crashes
- Tolerations for custom node scheduling

---

## 📁 File Structure

| File                          | Purpose                                 |
|-------------------------------|-----------------------------------------|
| `storage-class.yaml`          | Defines a local StorageClass            |
| `mysql-secret.yaml`           | Stores MySQL root password as a Secret  |
| `mysql-pv-pvc.yaml`           | Configures PersistentVolume and PVC     |
| `mysql-headless-service.yaml` | Creates a Headless Service              |
| `mysql-statefulset.yaml`      | Deploys MySQL via StatefulSet           |

---

## ✅ Prerequisites

- Kubernetes cluster with:
  - 1 Master node
  - 2 Worker nodes
- Taints applied on database nodes (e.g. `workload=database:NoSchedule`)
- `kubectl` configured and working
- Node directory `/data/mysql` exists and has write access:
  ```bash
  sudo mkdir -p /data/mysql && sudo chmod -R 777 /data/mysql
  ```


## 🚀 Deployment Steps

### 1.Apply the local StorageClass
 >>> you can check my `storage-class.yaml` file in the repo :

```bash
kubectl apply -f storage-class.yaml
```
After successful creation you can get StorageClass and you can see :

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab23-Statefulset-Deployment/images/get%20sc.png)
---

### 2.Create the MySQL root password Secret
 >>> you can check my `mysql-secret.yaml` file in the repo :

```bash
kubectl apply -f mysql-secret.yaml
```
After successful creation you can get secrets and you can see :

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab23-Statefulset-Deployment/images/get%20secrets.png)
---

### 3. Create PersistentVolume 
 >>> you can check my `mysql-pv.yaml` file in the repo :

```bash
kubectl apply -f mysql-pv.yaml
```
you can see the pv created :
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab23-Statefulset-Deployment/images/get%20pv.png)
---

### 4.Create a Headless Service for StatefulSet networking
 >>> you can check my `mysql-headless-service.yaml` file in the repo :

```bash
kubectl apply -f mysql-headless-service.yaml
```
### 5.Deploy the StatefulSet
 >>> you can check my `mysql-statefulset.yaml` file in the repo :

```bash
kubectl apply -f mysql-statefulset.yaml
```
you can see the pod and pvc created :

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab23-Statefulset-Deployment/images/get%20pod.png)
---
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab23-Statefulset-Deployment/images/get%20pvc.png)
---

## 📌 Result:

- After successful deployment, your MySQL StatefulSet will:
- Run persistently on worker nodes
- Retain data using local host storage
- Be reachable via headless service mysql.default.svc.cluster.local
- Be resilient against restarts and reboots


### and you can access this by:
```bash
kubectl exec -it mysql-0 -- mysql -u root -p
```

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab23-Statefulset-Deployment/images/access%20pod%20.png)
---


## 🧠 Author
Mohamed Magdy 

  
