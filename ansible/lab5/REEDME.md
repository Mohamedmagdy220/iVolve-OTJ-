# 📘 Ansible Playbooks for Web Server Configuration

This lab demonstrates the basic use of shell scripting to automate database backup tasks using `mysqldump` and `cron`.

## 🧪 Lab Objective

Automate the deployment of a web server using Ansible Playbooks. This includes:

- Writing an Ansible playbook.
- Installing Nginx on the managed node.
- Customizing the default web page.
- Verifying that the configuration was successfully applied.---
## 🗂️ Project Structure

```bash
lab5/
├── inventory            # Ansible inventory file
├── webserver.yml        # Main Ansible playbook
└── ansible.cfg          # ansible configuration file
└── README.md            # Documentation
```

## Step-by-Step Instructions

### 🔧 Step 1: Ansible Inventory Setup

Create a file named inventory:

```bash
[webservers]
192.168.88.130 ansible_user=your_user 
```

Create a file named ansible.cfg:
for verify the inventory that you created

```bash
[defaults]
inventory = ./inventory
remote_user = ubuntu 
```
### 🛠️ Step 2: Write the Ansible Playbook
Create a file named webserver.yml:

```bash
---
- name: Configure Nginx Web Server
  hosts: webservers
  become: yes

  tasks:

    - name: Install Nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Customize index.html
      copy:
        content: "<h1>Welcome to My Ansible Deployed Web Server</h1>"
        dest: /var/www/html/index.nginx-debian.html
        owner: www-data
        group: www-data
        mode: '0644'

    - name: Ensure Nginx is running and enabled
      service:
        name: nginx
        state: started
        enabled: yes

```
### 🔓 Step 3: Enable Passwordless sudo on Managed Node

On the target node (192.168.88.130):

```bash
sudo visudo
```
Add the following line at the end of the file:
```bash
your_user ALL=(ALL) NOPASSWD: ALL
```
This allows Ansible to run with become: yes without asking for a password.

### 🚀 Step 4: Run the Playbook

```bash
ansible-playbook  webserver.yml
```

### ✅ Step 5: Verify the Setup

SSH into the managed node:

```bash
ssh your_user@192.168.88.130
```
Then run:

```bash
curl http://localhost
```

You should see:

```bash
<h1>Welcome to My Ansible Deployed Web Server</h1>
```

## 📌 Notes

- Make sure python3 is installed on the managed node for Ansible to work.
- The index.nginx-debian.html is used because it's the default file served by Nginx on Ubuntu/Debian.

## 🛠️ Author

Prepared by: Mohamed Magdy
