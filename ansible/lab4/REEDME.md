# 📘 Lab 4: Ansible Installation & Setup

This lab demonstrates the basic use of shell scripting to automate database backup tasks using `mysqldump` and `cron`.

## Objective

Set up Ansible Automation to manage remote servers from a Control Node, enabling secure communication via SSH and executing commands remotely.
---

## Prerequisites

- Two Linux machines (or VMs):
- Control Node (with Ansible installed)
- Managed Node (remote server to be controlled)
- SSH access enabled between both nodes.

---

## Step-by-Step Instructions

### 🔹 Step 1: Install Ansible on Control Node

Use the following command (for Debian/Ubuntu systems):

```bash
sudo apt update
sudo apt install ansible -y
```

### 🔹 Step 2: Create the Inventory File

```bash
sudo mkdir -p /etc/ansible
sudo nano /etc/ansible/hostss
```

Add your managed node(s):

```bash
[webservers]
192.168.88.130 ansible_user=magdy
```
Replace 192.168.88.130 with the IP address of your managed node.

### 🔹 Step 3: Generate SSH Key on Control Node

Run the following to generate an SSH key pair:

```bash
ssh-keygen
```
Press Enter through all prompts to accept defaults (no passphrase needed).

### 🔹 Step 4: Transfer Public Key to Managed Node

Use ssh-copy-id to enable passwordless SSH:

```bash
ssh-copy-id magdy@192.168.88.130
```

Accept the SSH fingerprint if prompted and enter the password once.

### 🔹 Step 5: Test Connection with Ping Module

Run the ping module to test:

```bash
ansible all -m ping
```
Expected Output:

```bash
192.168.56.10 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```
### 🔹 Step 6: Run Ad-hoc Command (Check Disk Space)

```bash
ansible all -a "df -h"
```
This should return the disk usage from the managed node.

## ✅ Final Check

Make sure:

- Inventory file exists at /etc/ansible/hosts
- SSH works without password from control node to managed node
- ansible all -m ping returns success

## 🛠️ Author

Prepared by: Mohamed Magdy
