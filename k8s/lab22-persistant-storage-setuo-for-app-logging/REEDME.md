# Persistent Storage Setup for Application Logging
Kubernetes Lab Guide
This guide provides a professional setup for persistent storage in Kubernetes to store application logs using PersistentVolume (PV) and PersistentVolumeClaim (PVC) with hostPath.


## ✅ Prerequisites
- A running Kubernetes cluster (Minikube, K3s, EKS, etc.).
- kubectl configured to access the cluster.
- SSH access to worker nodes (if using hostPath).
- in this lab i used (1vm for master node , 2vms for worker nodes)

## 📂 Step 1: Prepare the Host Directory
On the two worker nodes where logs will be stored:

```bash
sudo mkdir -p /mnt/app-logs
sudo chmod 777 /mnt/app-logs
```

## 🛠️ Step 2: Create PersistentVolume (PV)
Create `pv-app-logs.yaml` like this:

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab22-persistant-storage-setuo-for-app-logging/images/pv-app-logs-yml.png)
---


## 📝 Step 3: Create PersistentVolumeClaim (PVC)
Create `pvc-app-logs.yaml` like this :

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab22-persistant-storage-setuo-for-app-logging/images/pvc-app-logs-yml.png)
---
Apply the PV and pvc:

```bash
kubectl apply -f pv-app-logs.yaml
kubectl apply -f pvc-app-logs.yaml
```

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab22-persistant-storage-setuo-for-app-logging/images/create%20pv%20and%20pvc.png)
---

Verify binding:

```bash
kubectl get pv
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab22-persistant-storage-setuo-for-app-logging/images/get%20pv.png)
---

```bash
kubectl get pvc
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab22-persistant-storage-setuo-for-app-logging/images/get%20pvc.png)
---


## 🚀 Step 4: Deploy a Test Pod
Create `test-pod.yaml` like this:

![image]()
---

## Bouns
i have used taint and toleration in this lab so in test pod i spicify the node witch the test pod will deployed at.
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab22-persistant-storage-setuo-for-app-logging/images/bouns%20for%20taints.png)
---

Apply the Pod:

```bash
kubectl apply -f test-pod.yaml
```
Check Pod status:

```bash
kubectl get pods
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab22-persistant-storage-setuo-for-app-logging/images/get%20pods.png)
---


## 🔍 Step 5: Verify Logging
Check logs on the worker node:
```bash
ssh worker1
cat /mnt/app-logs/app.log
```

✅ Expected output:
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab22-persistant-storage-setuo-for-app-logging/images/cat%20log%20on%20worker1.png)
---

## 🧹 Cleanup
Delete resources:

```bash
kubectl delete pod test-logger
kubectl delete pvc app-logs-pvc
kubectl delete pv app-logs-pv
```  













