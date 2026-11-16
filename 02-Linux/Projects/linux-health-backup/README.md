# Linux Server Health & Backup Automation

A Bash scripting project for monitoring Linux server health and automating directory backups.

This project was developed as part of my DevOps learning journey to practise Linux administration, shell scripting, system monitoring, backup automation, error handling, and logging.

---

## 1. Project Overview

Linux servers require regular monitoring to ensure that system resources are being used properly and important data is backed up safely.

In this project, I developed two Bash scripts:

1. `health_check.sh` – Monitors Linux server health.
2. `backup.sh` – Automatically creates and manages directory backups.

The project also includes a configuration file to manage backup settings and a logging system to record backup activities.

---

## 2. Features

### Server Health Monitoring

- Display hostname and current date/time.
- Check system uptime.
- Display CPU core count.
- Monitor CPU load average.
- Check RAM usage.
- Check disk usage.
- Display top 5 memory-consuming processes.

### Automated Backup

- Create compressed backups using `tar.gz`.
- Generate timestamp-based backup filenames.
- Verify backup archives using gzip.
- Configure source and destination directories.
- Automatically remove old backups.
- Maintain a configurable backup retention count.
- Record backup activities in log files.
- Handle errors such as missing source directories.

---

## 3. Technologies Used

- Linux (Ubuntu)
- Bash Shell Scripting
- tar
- gzip
- Linux system monitoring commands
- Git and GitHub

---

## 4. Project Structure

```text
linux-health-backup/
├── README.md
├── .gitignore
├── health_check.sh
├── backup.sh
├── config/
│   └── config.conf
├── backups/
├── logs/
└── sample-data/
    ├── database.sql
    ├── file1.txt
    └── file2.txt
```

### Directory Explanation

| File / Directory | Purpose |
|---|---|
| `health_check.sh` | Monitors Linux server health |
| `backup.sh` | Creates and manages backups |
| `config/` | Stores backup configuration |
| `config.conf` | Defines backup settings |
| `backups/` | Stores generated backup archives |
| `logs/` | Stores backup activity logs |
| `sample-data/` | Contains files used for backup testing |
| `.gitignore` | Excludes generated files from Git |

---

## 5. Project Development Process

### Step 1: Create the Project Directory

First, I created the project directory and navigated into it.

```bash
mkdir -p linux-health-backup
cd linux-health-backup
```

Created the required directories:

```bash
mkdir -p config backups logs sample-data restore-test
```

**Explanation:**

- `mkdir` creates directories.
- `-p` creates parent directories if they do not exist.
- Separate directories keep the project organised.

### Step 2: Create Sample Data

Created sample files to test the backup functionality.

```bash
touch sample-data/file1.txt
touch sample-data/file2.txt
touch sample-data/database.sql
```

Added sample content:

```bash
echo "This is sample file 1" > sample-data/file1.txt
echo "This is sample file 2" > sample-data/file2.txt
echo "CREATE DATABASE test_db;" > sample-data/database.sql
```

**Explanation:**

These files act as sample data that the backup script will compress and store in the backup directory.

### Step 3: Create the Server Health Monitoring Script

Created the script:

```bash
vim health_check.sh
```

The script collects important Linux system information using commands such as:

| Command | Purpose |
|---|---|
| `hostname` | Displays system hostname |
| `date` | Displays current date and time |
| `uptime` | Displays system uptime |
| `nproc` | Displays CPU core count |
| `uptime` | Provides load average |
| `free -h` | Displays memory usage |
| `df -h /` | Displays root disk usage |
| `ps` | Displays running processes |

The script combines these commands and displays the information in a structured server health report.

Made the script executable:

```bash
chmod +x health_check.sh
```

Executed it:

```bash
./health_check.sh
```

**Result:**

The script successfully displayed hostname, uptime, CPU information, memory usage, disk usage, and the top 5 memory-consuming processes.

### Step 4: Create the Backup Configuration File

Created the configuration file:

```bash
vim config/config.conf
```

Added the following configuration:

```bash
SOURCE_DIR="./sample-data"
BACKUP_DIR="./backups"
LOG_FILE="./logs/backup.log"
RETENTION_COUNT=3
```

**Explanation:**

- `SOURCE_DIR` defines which directory should be backed up.
- `BACKUP_DIR` defines where backups should be stored.
- `LOG_FILE` defines where backup activity should be recorded.
- `RETENTION_COUNT` defines how many backups should be retained.

This makes it easier to change backup settings without modifying the main script.

### Step 5: Develop the Automated Backup Script

Created the backup script:

```bash
vim backup.sh
```

The script performs the following operations:

1. Loads configuration from `config.conf`.
2. Identifies the project directory.
3. Resolves configured paths.
4. Creates required directories.
5. Validates the retention configuration.
6. Checks whether the source directory exists.
7. Generates a timestamp-based backup filename.
8. Creates a compressed backup using `tar`.
9. Verifies the archive using `gzip -t`.
10. Deletes older backups when the retention limit is exceeded.
11. Records all important activities in the log file.

Made the script executable:

```bash
chmod +x backup.sh
```

Executed the backup script:

```bash
./backup.sh
```

### Step 6: Understand the Backup Process

The backup script uses several important Linux commands and Bash features.

| Command / Feature | Purpose |
|---|---|
| `source` | Loads configuration variables |
| `mkdir -p` | Creates required directories |
| `date` | Generates timestamps |
| `tar -czf` | Creates compressed archives |
| `gzip -t` | Verifies compressed archives |
| `find` | Locates existing backup files |
| `sort` | Sorts backup filenames |
| `mapfile` | Stores command output in a Bash array |
| `while` | Repeats backup deletion while needed |
| `rm` | Removes old backup files |
| `tee -a` | Displays and appends log messages |

### Step 7: Test Backup Creation

Executed:

```bash
./backup.sh
```

Checked generated backups:

```bash
ls -lh backups/
```

Checked the contents of an archive:

```bash
tar -tzvf backups/backup_TIMESTAMP.tar.gz
```

The archive contained the sample-data directory and its files.

### Step 8: Test Backup Restoration

Created a restore directory:

```bash
mkdir -p restore-test
```

Extracted a backup:

```bash
tar -xzvf backups/backup_TIMESTAMP.tar.gz -C restore-test/
```

Verified the restored files:

```bash
tree restore-test/
```

Compared original and restored data:

```bash
diff -r sample-data/ restore-test/sample-data/
```

No output from the `diff` command indicated that the restored files matched the original files.

### Step 9: Implement Automatic Backup Rotation

Configured the backup retention limit:

```bash
RETENTION_COUNT=3
```

The backup script automatically removes the oldest backup when the number of backups exceeds the configured retention count.

Tested backup rotation by creating another backup.

Checked the number of available backups:

```bash
find backups/ -maxdepth 1 -type f -name 'backup_*.tar.gz' | wc -l
```

**Expected Result:**

```text
3
```

The script successfully deleted the oldest backup and retained the latest three backups.

### Step 10: Implement Logging

Backup activities are recorded in:

```text
logs/backup.log
```

The log includes:

- Backup start time.
- Backup creation status.
- Backup verification status.
- Old backup deletion details.
- Backup completion status.
- Error messages.

To view logs:

```bash
cat logs/backup.log
```

To view the latest entries:

```bash
tail -n 15 logs/backup.log
```

### Step 11: Test Error Handling

Tested the script with an invalid source directory by temporarily changing the configuration:

```bash
SOURCE_DIR="./missing-data"
```

Executed:

```bash
./backup.sh
echo $?
```

The script detected the missing source directory and exited with a non-zero status.

Restored the original configuration afterward:

```bash
SOURCE_DIR="./sample-data"
```

This test verified that the script handles a missing source directory instead of attempting to create an invalid backup.

---

## 6. Final Project Verification

Performed the following checks:

### Check Shell Script Syntax

```bash
bash -n health_check.sh backup.sh
```

### Run Health Check

```bash
./health_check.sh
```

### Run Backup

```bash
./backup.sh
```

### Check Backup Count

```bash
find backups/ -maxdepth 1 -type f -name 'backup_*.tar.gz' | wc -l
```

### Check Backup Logs

```bash
tail -n 15 logs/backup.log
```

All major project operations were successfully tested.

---

## 7. Learning Outcomes

Through this project, I gained practical experience in:

- Linux system administration.
- Bash shell scripting.
- Variables and configuration files.
- Conditional statements.
- Loops and functions.
- File and directory management.
- Linux system monitoring.
- Backup and restore operations.
- Archive compression and verification.
- Error handling.
- Logging.
- Automated backup rotation.
- Testing and debugging shell scripts.

---

## 8. Future Improvements

Possible improvements for this project:

- Schedule automatic backups using Cron.
- Send email notifications after backup completion.
- Upload backups to remote storage.
- Add backup encryption.
- Monitor additional server metrics.
- Add automated backup restoration testing.

---

## 9. Author

**Niraj Dhore**

GitHub: https://github.com/niraj1234-svg

Project: Linux Server Health & Backup Automation

Part of my DevOps Learning Journey.
