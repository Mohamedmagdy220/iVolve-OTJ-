#!/bin/bash

BACKUP_DIR="$HOME/lab1/mysql_backups"
DATE=$(date +%F)

USER="root"
PASSWORD="password"

mysqldump -u $USER -p$PASSWORD  --all-databases > "$BACKUP_DIR/MySQL_backup_$DATE.sql"
