# Kubernetes Namespace and Resource Quota Management

This guide provides comprehensive instructions for managing Kubernetes namespaces and enforcing resource quotas.

## Overview
This lab demonstrates how to:
1. Create a namespace called `ivolive`
2. Apply a resource quota to limit the namespace to 2 pods

## Prerequisites
- Kubernetes cluster (v1.19+ recommended)
- kubectl configured with cluster access
- Appropriate user permissions

## YAML Configuration Files

### 1. Namespace Definition (`namespace.yaml`)
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: ivolve
```

### 2. Resource Quota Definition (`resource-quota.yaml`)
```yml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: pod-quota
  namespace: ivolve
spec:
  hard:
    pods: "2"
```

## Deployment Commands

```bash
kubectl apply -f namespace.yaml
kubectl apply -f resource-quota.yaml
```

## Verification Commands

### Verify Namespace Creation
```bash
kubectl get namespaces
```
![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab20-namespace-and-resourse-qouta/get%20namespaces.png)
---

### Verify Resource Quota Application
```bash
kubectl get resourcequotas -n ivolve
```

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/k8s/lab20-namespace-and-resourse-qouta/get%20reasourse%20qoutas.png)
---

## Cleanup

To remove all created resources:

```bash
kubectl delete namespace ivolve
```





