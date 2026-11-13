#!/bin/bash

SOURCE="/devops_workspace"
BACKUP_DIR="/backups"
BACKUP_FILE="$BACKUP_DIR/backup_$(date +%F).tar.gz"

sudo mkdir -p "$BACKUP_DIR"

if sudo tar -czf "$BACKUP_FILE" -C / devops_workspace; then
    echo -e "\e[32mBackup successful: $BACKUP_FILE\e[0m"
else
    echo -e "\e[31mBackup failed!\e[0m"
    exit 1
fi
