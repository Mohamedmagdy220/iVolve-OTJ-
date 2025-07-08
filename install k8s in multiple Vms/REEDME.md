# Kubernetes Installation Guide
This document provides a step-by-step guide to install and configure a Kubernetes cluster on CentOS/RHEL systems.

## Prerequisites

- CentOS/RHEL servers (one for master, one or more for worker nodes)
- Root or sudo privileges
- Internet access on all nodes
- Minimum 2GB RAM and 2 CPUs per machine
- Unique hostnames for each node

## STEPS:

### Step 1: System Configuration (All Nodes)

Disable swap (required by Kubernetes):
```bash
swapoff -a
sed -i '/ swap / s/^/#/' /etc/fstab
```

Enable kernel modules:
```bash
modprobe overlay
modprobe br_netfilter
```

Configure network settings:
```bash
cat <<EOF | tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sysctl --system
```

### Step 2: Install Container Runtime (All Nodes)

Option 1: Install containerd directly
```bash
yum install -y containerd
containerd config default | tee /etc/containerd/config.toml
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

systemctl restart containerd
systemctl enable containerd
```

Option 2: Install containerd via Docker repository:
```bash
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum install -y containerd.io
mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml

sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
systemctl restart containerd
systemctl enable containerd
systemctl status containerd
```


### Step 3: Install Kubernetes Components (All Nodes)

```bash
cat <<EOF | tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/repodata/repomd.xml.key
EOF

yum install -y kubelet kubeadm kubectl
systemctl enable kubelet
```

### Step 4: Initialize Kubernetes Cluster (Master Node Only)
```bash
kubeadm init --pod-network-cidr=192.168.0.0/16
```
#### After successful initialization, you'll receive a kubeadm join command with a token. Save this command for worker nodes.

```bash
kubeadm join 192.168.1.10:6443 --token gfqgnp.85ya0cau53jocke1 \
        --discovery-token-ca-cert-hash sha256:1e19fbd566c23a88d4d3984a3631358c982401230aec3551f2a48511ecb856a6
```

### Step 5: Configure kubectl (Master Node Only)
```bash
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
```

### Step 6: Install Network Plugin (Master Node Only)

```bash
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```

### Step 7: Join Worker Nodes

On each worker node, run the `kubeadm join` command you received after initialization:

```bash
kubeadm join 192.168.X.X:6443 --token abcdef.0123456789abcdef \
    --discovery-token-ca-cert-hash sha256:xxxxxxxxxxxxxxxxxxx
```

### Verification (Master Node)
Check cluster status:

```bash
kubectl get nodes
```


## Additional Notes
- Ensure firewalls (iptables/nftables) are properly configured
- Disable SELinux or configure it to work with Kubernetes
- The token from kubeadm init expires after 24 hours by default
- For production environments, consider using more secure methods for joining nodes


## Troubleshooting
- If nodes don't show as Ready, check network plugin installation
- Verify containerd is running on all nodes
- Check journalctl -u kubelet for errors on problematic nodes








