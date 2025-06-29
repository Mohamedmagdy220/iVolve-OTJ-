# 🔧 Ansible Dynamic Inventory with AWS EC2

This project demonstrates how to use **Ansible dynamic inventory** with AWS EC2 instances tagged with `Name=ivolve`.

---
## 🎯 Objective

- Provision an AWS EC2 instance with tag `Name=ivolve`.
- Configure Ansible Dynamic Inventory using AWS EC2 plugin.
- Automatically discover and manage EC2 instances based on tag.
- List target hosts using `ansible-inventory` command.

---

## 📁 Project Structure

```
lab8_ansible_project/
├── inventory/
│   └── aws_ec2.yaml      # Dynamic inventory configuration
├── ansible.cfg           # Ansible configuration file
└── README.md             # This documentation
```

---
## 🛠️ Prerequisites

- AWS account with access keys.
- EC2 instance running with:
  - Tag: `Name=ivolve`
  - Key pair for SSH access
  - Security group allowing SSH (port 22)
- Ansible installed on control node.
- `amazon.aws` collection installed.

---

## 🚀 Quick Start

### 1️⃣ Clone the repository

```bash
git clone https://github.com/yourusername/lab8_ansible_project.git
cd lab8_ansible_project
```

### 2️⃣ Set up Python virtual environment (optional)

```bash
python3 -m venv ansible-env
source ansible-env/bin/activate
```

### 3️⃣ Install Ansible and AWS dependencies

```bash
pip install --upgrade pip
pip install ansible boto3 botocore
ansible-galaxy collection install amazon.aws
```

### 4️⃣ Configure AWS credentials

```bash
aws configure
```
You will be prompted to enter:

```bash
AWS Access Key ID [None]: <your-access-key-id>
AWS Secret Access Key [None]: <your-secret-access-key>
Default region name [None]: us-east-1
Default output format [None]: json
```

Make sure the IAM user has permission for:
- `ec2:DescribeInstances`
- `ec2:DescribeTags`

### 5 Test dynamic inventory

```bash
ansible-inventory -i inventory/aws_ec2.yaml --list
```

You should see your EC2 instance(s) listed under the tag group `tag_Name_ivolve` like this.

![image](https://github.com/Mohamedmagdy220/iVolve-OTJ-/blob/main/ansible/lab8/images/list%20ec2%20with%20filter%20ivolve.png)
---

## 🛠️ ansible.cfg Configuration

```ini
[inventory]
enable_plugins = host_list, script, auto, yaml, ini, toml
```

---

## 📌 Notes

- This setup assumes EC2 instances are tagged with `Name=ivolve`
- The region is set to `us-east-1` by default — update `aws_ec2.yaml` if needed.
- Make sure SSH access is set up if running actual playbooks.

---
