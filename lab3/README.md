# Lab 3: SSH Configurations (From Windows Host to Linux VM)

## Objective:
Set up SSH access **from your Windows machine** to a **Linux VM running on VMware** using SSH key-based authentication (passwordless login), and configure an SSH alias to simplify the connection command (e.g., `ssh involve`).

---

## ✅ Step 1: Generate SSH Key on Windows

Use **Git Bash** or **PowerShell** on your Windows machine and run:

```bash
ssh-keygen
```

## ✅ Step 2: Copy Public Key to Linux VM

Using ssh-copy-id
Run the following command from Git Bash or PowerShell:

```bash
ssh-copy-id magdy@v192.168.88.131
```

## ✅ Step 3: Create an SSH Alias on Windows

Open (or create) the SSH config file:

```bash
notepad C:\Users\ENG_M\.ssh\config
```

Add the following configuration:

```bash
Host ivolve
    HostName 192.168.88.131
    User magdy
    IdentityFile C:/Users/ENG_M/.ssh/id_rsa
```

## ✅ Step 4: Connect Using the Alias

Now, to connect to your VM, simply run:

```bash
ssh involve
```

## 📌 Notes:

Make sure the Linux VM has SSH server running:

```bash
sudo systemctl status ssh
```

## ✅ Tested On:

Windows 10 host

Ubuntu Linux VM on VMware Workstation

Git Bash for SSH from Windows


