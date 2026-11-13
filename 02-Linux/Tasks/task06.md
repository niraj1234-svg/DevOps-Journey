# Task 06 – Automate Backups with Shell Scripting

## Objective

- Write a shell script to back up /devops_workspace.
- Create a compressed backup using tar.gz.
- Save the backup inside /backups.
- Include the current date in the backup filename.
- Display a green success message using echo -e.
- Schedule automatic backups using cron.

## 1. Create the Shell Script

Command:

    vim backup_devops.sh

Script:

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

## 2. Script Explanation

- #!/bin/bash: Specifies Bash as the script interpreter.
- SOURCE: Stores the source directory path.
- BACKUP_DIR: Stores the backup destination.
- BACKUP_FILE: Generates the backup filename using the current date.
- date +%F: Returns date in YYYY-MM-DD format.
- mkdir -p: Creates the backup directory if it does not exist.
- tar -czf: Creates a compressed tar.gz archive.
- if: Checks whether the backup command succeeds.
- echo -e: Displays formatted text with escape sequences.
- \e[32m: Changes text colour to green.
- \e[31m: Changes text colour to red.
- \e[0m: Resets text formatting.
- exit 1: Exits the script with an error status.

## 3. Make Script Executable

Command:

    chmod +x backup_devops.sh

Verify:

    ls -l backup_devops.sh

Expected permission:

    -rwxrwxr-x

Explanation:

- chmod: Changes file permissions.
- +x: Adds execute permission.

## 4. Execute the Backup Script

Command:

    ./backup_devops.sh

Expected output:

    Backup successful: /backups/backup_2026-11-13.tar.gz

The success message appears in green text.

## 5. Verify Backup File

Command:

    sudo ls -lh /backups/

Example output:

    backup_2026-11-13.tar.gz

Explanation:

- ls: Lists directory contents.
- -l: Displays detailed information.
- -h: Displays file sizes in human-readable format.

## 6. Verify Backup Contents

Command:

    sudo tar -tzf /backups/backup_$(date +%F).tar.gz

Example output:

    devops_workspace/

Explanation:

- tar: Archive management utility.
- -t: Lists archive contents.
- -z: Handles gzip compression.
- -f: Specifies archive filename.

## 7. Schedule Backup Using CRON

Cron is a Linux utility used to schedule commands and scripts automatically.

Open the current user's crontab:

    crontab -e

Cron syntax:

    * * * * * command

Field explanation:

- First *: Minute
- Second *: Hour
- Third *: Day of month
- Fourth *: Month
- Fifth *: Day of week

Example: Run backup every day at 2:00 AM.

    0 2 * * * /home/ubuntu/DevOps-Journey/02-Linux/Tasks/backup_devops.sh

Note: Use the actual absolute path of your script.

Save and exit the editor.

Verify scheduled cron jobs:

    crontab -l

Important:
The script currently uses sudo for creating the backup directory and archive. For unattended cron execution, configure permissions appropriately or use root's crontab so the scheduled job does not wait for a sudo password.

## 8. Important Commands Summary

| Command | Purpose |
|---|---|
| vim | Create or edit shell script |
| chmod +x | Make script executable |
| ./script.sh | Execute shell script |
| date +%F | Get current date |
| mkdir -p | Create backup directory |
| tar -czf | Create compressed archive |
| tar -tzf | List archive contents |
| ls -lh | Check backup file |
| crontab -e | Edit scheduled jobs |
| crontab -l | List scheduled jobs |

## 9. Completion Checklist

- [x] Created backup_devops.sh
- [x] Wrote the backup script
- [x] Added green success message
- [x] Added red failure message
- [x] Made script executable
- [x] Executed the script successfully
- [x] Created /backups directory
- [x] Verified backup file
- [x] Verified archive contents
- [ ] Configured cron scheduling
- [ ] Verified cron execution

## 10. Key Learning

- Shell scripting automates repetitive Linux tasks.
- tar creates and manages archive files.
- gzip compresses files.
- date +%F generates date-based filenames.
- chmod +x makes scripts executable.
- echo -e supports formatted terminal output.
- Cron automates commands at scheduled times.
