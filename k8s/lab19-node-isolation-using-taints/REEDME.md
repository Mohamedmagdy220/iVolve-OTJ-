# Lab 19: Node Isolation Using Taints in Kubernetes
A Hands-on Guide to Controlling Pod Scheduling with Taints


## 📌 Overview
This lab demonstrates how Kubernetes taints can be used to restrict pod scheduling on specific nodes. By applying taints with the NoSchedule effect, we ensure that only pods with matching tolerations can run on designated nodes.


## 🎯 Objectives
✅ Apply taints to three nodes with different workload types:
- workload=master:NoSchedule
- workload=app:NoSchedule
- workload=database:NoSchedule
✅ Verify taints are correctly configured.


## ⚙️ Prerequisites
✔ A 3-node Kubernetes cluster (Minikube, Kubeadm, EKS, etc.)
✔ kubectl configured with admin access
✔ Basic understanding of Kubernetes nodes and pods


## 🔧 Step-by-Step Lab Guide

### 1️⃣ List Available Nodes

Check your cluster nodes before applying taints:
```bash
kubectl get nodes
```

![image]()
---

### 2️⃣ Apply Taints

Master Workload Node (NoSchedule)
```bash
kubectl taint nodes node1 workload=master:NoSchedule
```

App Workload Node (NoSchedule)
```bash
kubectl taint nodes node2 workload=app:NoSchedule
```

Database Workload Node (NoSchedule)
```bash
kubectl taint nodes node3 workload=database:NoSchedule
```


### 3️⃣ Verify Taints

```bash
kubectl describe nodes | grep Taints
```
![image]()
---

## 🧹 Cleanup
To remove taints after completing the lab:
```bash
kubectl taint nodes node1 workload-
kubectl taint nodes node2 workload-
kubectl taint nodes node3 workload-
```






