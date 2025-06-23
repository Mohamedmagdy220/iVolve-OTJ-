# Lab 1: Shell Scripting Basics

This lab demonstrates the basic use of shell scripting to automate database backup tasks using `mysqldump` and `cron`.

## Objective

- Install MySQL database.
- Create a shell script that backs up a MySQL database daily.
- Store the backup in a dedicated directory.
- Schedule the script to run automatically every day at **5:00 PM** using `cron`.

---

## Prerequisites

- Linux/Unix environment
- Root or sudo privileges
- MySQL server installed
- Basic knowledge of Bash scripting

---

## Step-by-Step Instructions

### 1. Install MySQL Server

Use the following command to install MySQL (for Debian/Ubuntu systems):

```bash
sudo apt update
sudo apt install mysql-server
```
### 2. Create a Backup Directory

```bash
mkdir -p ~/mysql_backups
```

### 3. Create the Shell Script

### 4. Make the script executable

```bash
chmod +x mysql_backup.sh
```
### 5. Schedule the Cron Job

Edit the crontab:

```bash
crontab -e
```

Add the following line to run the script every day at 5:00 PM:

```bash
0 17 * * * /mysql_backup.sh
```

## ✅ Output

Backups will be saved in the following format:

```bash
~/mysql_backups/MySQL_backup_YYYY-MM-DD.sql
```

## 🛠️ Author

Prepared by: Mohamed Magdy
