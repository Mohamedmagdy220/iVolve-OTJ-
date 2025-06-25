# 🛠️ Ansible Project: Automated MySQL Setup with Vault Encryption

## 📌 Objective

This Ansible playbook automates the full installation and secure configuration of a MySQL server on a remote node. It performs the following:

- Installs MySQL server and required Python modules.
- Sets the root password securely.
- Creates a database named `iVolve`.
- Creates a dedicated database user with full privileges.
- Uses **Ansible Vault** to encrypt sensitive credentials.
- Verifies database creation by listing available databases.

---

## ✅ Requirements

- Ubuntu-based managed node.
- Python 3 and pip installed.
- Ansible on control node.
- SSH access to the managed node.

## 📁 Project Structure

```bash
project/
├── ancible.cfg             # configuration file for verfying the inventory 
├── iinventory              # special inventory for hosts
├── mysql_setup.yml        # Main playbook
├── vars.yml               # Encrypted file containing DB credentials (via Ansible Vault)
├── README.md              # Project documentation
```

## 🔐 Variables (Encrypted with Vault)

Edit securely:

```bash
ansible-vault edit vars.yml
```

Recommended content:

db_user: magdy
db_pass: pass
root_pass: pass

## 🚀 Usage Instructions

1. Install required collections

```bash
ansible-galaxy collection install community.mysql
```

2. Encrypt your variable file

```bash
ansible-vault create vars.yml
``` 
3. Add your managed node(s) to the inventory filelike this:

[webservers]
192.168.88.130 ansible_user=magdy

3. Run the playbook
   
```bash
ansible-playbook mysql_setup.yml --ask-vault-pass
```

you will see the database that created in the managed nodes:


## 📌 Notes

- Avoid using the root MySQL account for app connections — a separate user like:(magdy) is created.
- Passwords are stored securely using Ansible Vault.
- Make sure to configure proper MySQL firewall access if connecting externally.



