#!/bin/bash

# Automated Backup with Rotation
# Keeps only the latest 3 backups.

# Check directory argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

SOURCE_DIR="${1%/}"

# Check whether directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

# Prevent backup inside the source directory
SOURCE_REAL=$(realpath "$SOURCE_DIR")
SCRIPT_DIR=$(realpath "$(dirname "$0")")

case "$SCRIPT_DIR/" in
    "$SOURCE_REAL/"*)
        echo "Error: Keep the script outside the source directory."
        exit 1
        ;;
esac

# Generate timestamp
TIMESTAMP=$(date +%F_%H-%M-%S-%N)	

BACKUP_DIR="$SOURCE_DIR/backup_$TIMESTAMP"

# Create backup directory
mkdir -p "$BACKUP_DIR" || exit 1

# Copy source contents, excluding backup folders
if ! find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 \
    ! -name 'backup_*' \
    -exec cp -a -t "$BACKUP_DIR" -- {} +; then

    echo "Backup failed!"
    rm -rf -- "$BACKUP_DIR"	
    exit 1
fi

echo "Backup created: $BACKUP_DIR"

# Keep only the latest 3 backups
mapfile -t BACKUPS < <(
    find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 \
        -type d -name 'backup_*' -printf '%f\n' |
    sort -r
)

if [ "${#BACKUPS[@]}" -gt 3 ]; then
    for ((i=3; i<${#BACKUPS[@]}; i++)); do
        rm -rf -- "$SOURCE_DIR/${BACKUPS[$i]}"
        echo "Old backup removed: ${BACKUPS[$i]}"
    done
fi

echo "Backup rotation completed successfully."
