
#!/bin/bash

set -Eeuo pipefail

# Project directory
PROJECT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Load configuration
source "$PROJECT_DIR/config/config.conf"

# Resolve paths relative to project directory
resolve_path() {
    case "$1" in
        /*) printf '%s\n' "$1" ;;
        *)  printf '%s/%s\n' "$PROJECT_DIR" "$1" ;;
    esac
}

SOURCE_DIR="$(resolve_path "$SOURCE_DIR")"
BACKUP_DIR="$(resolve_path "$BACKUP_DIR")"
LOG_FILE="$(resolve_path "$LOG_FILE")"

# Create required directories
mkdir -p "$BACKUP_DIR" "$(dirname "$LOG_FILE")"

# Logging function
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Validate configuration
if ! [[ "$RETENTION_COUNT" =~ ^[1-9][0-9]*$ ]]; then
    log_message "ERROR: Invalid retention count"
    exit 1
fi

# Validate source directory
if [ ! -d "$SOURCE_DIR" ]; then
    log_message "ERROR: Source directory not found: $SOURCE_DIR"
    exit 1
fi

# Generate timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

log_message "Backup started"

# Create and verify backup
if tar -czf "$BACKUP_FILE" \
    -C "$(dirname "$SOURCE_DIR")" \
    "$(basename "$SOURCE_DIR")" &&
    gzip -t "$BACKUP_FILE"; then

    log_message "SUCCESS: Backup created: $BACKUP_FILE"

else
    rm -f -- "$BACKUP_FILE"
    log_message "ERROR: Backup creation or verification failed"
    exit 1
fi

# Find existing backups in chronological order
mapfile -t BACKUP_FILES < <(
    find "$BACKUP_DIR" -maxdepth 1 -type f \
    -name 'backup_*.tar.gz' -printf '%f\n' | sort
)

# Backup rotation
while [ "${#BACKUP_FILES[@]}" -gt "$RETENTION_COUNT" ]; do

    OLDEST_BACKUP="${BACKUP_FILES[0]}"

    rm -- "$BACKUP_DIR/$OLDEST_BACKUP"

    log_message "Removed old backup: $OLDEST_BACKUP"

    BACKUP_FILES=("${BACKUP_FILES[@]:1}")
done

log_message "Backup process completed"

