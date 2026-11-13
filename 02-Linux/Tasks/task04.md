# Task 04 – Volume Management & Disk Usage

## Objective

- Create a directory /mnt/devops_data.
- Create a loop device for local practice.
- Format and mount the volume.
- Verify the mount using df -h and mount commands.

## 1. Create Mount Point Directory

Command:

    sudo mkdir -p /mnt/devops_data

Explanation:

- mkdir: Creates a directory.
- -p: Creates parent directories if required.
- /mnt/devops_data: Directory where the volume will be mounted.

## 2. Create a 100 MB Disk Image

Command:

    sudo fallocate -l 100M /tmp/devops_volume.img

Verify:

    ls -lh /tmp/devops_volume.img

Explanation:

- fallocate: Creates a file with allocated space.
- -l: Specifies the file size.
- 100M: Creates a 100 MB image file.
- /tmp/devops_volume.img: Disk image file location.

## 3. Create an ext4 Filesystem

Command:

    sudo mkfs.ext4 /tmp/devops_volume.img

Explanation:

- mkfs: Creates a filesystem.
- ext4: Linux filesystem type.
- This command prepares the image file for mounting.

## 4. Attach Loop Device

Command:

    sudo losetup -fP /tmp/devops_volume.img

Check assigned loop device:

    sudo losetup -j /tmp/devops_volume.img

Example output:

    /dev/loop12: []: (/tmp/devops_volume.img)

Explanation:

- losetup: Manages loop devices.
- -f: Finds the first available loop device.
- -P: Scans for partitions.
- /dev/loop12: Assigned loop device (example).

## 5. Mount the Volume

Command:

    sudo mount /dev/loop12 /mnt/devops_data

Note: Replace /dev/loop12 with the actual loop device assigned on your system.

Explanation:

- mount: Attaches a filesystem to a directory.
- /dev/loop12: Source loop device.
- /mnt/devops_data: Mount point.

## 6. Verify Disk Usage

Command:

    df -h

Explanation:

- df: Displays filesystem disk space usage.
- -h: Displays sizes in human-readable format.

Example output:

    /dev/loop12  90M  152K  83M  1%  /mnt/devops_data

Important columns:

- Size: Total filesystem size.
- Used: Used disk space.
- Avail: Available disk space.
- Use%: Percentage of used space.
- Mounted on: Mount location.

## 7. Verify Mount Information

Command:

    mount | grep devops_data

Example output:

    /dev/loop12 on /mnt/devops_data type ext4 (rw,relatime)

Explanation:

- mount: Displays currently mounted filesystems.
- grep: Filters matching lines.
- ext4: Filesystem type.
- rw: Read and write mode.
- /mnt/devops_data: Mount location.

## 8. Test Write Access

Command:

    sudo touch /mnt/devops_data/test.txt

Verify:

    ls -l /mnt/devops_data/

This confirms that a file can be created inside the mounted volume.

## 9. Important Commands Summary

| Command | Purpose |
|---|---|
| mkdir -p | Create mount point |
| fallocate | Create disk image |
| mkfs.ext4 | Create ext4 filesystem |
| losetup | Attach loop device |
| mount | Mount filesystem |
| df -h | Check disk usage |
| mount | Display mounted filesystems |
| grep | Filter output |
| touch | Create test file |

## 10. Completion Checklist

- [x] Created /mnt/devops_data
- [x] Created 100 MB disk image
- [x] Created ext4 filesystem
- [x] Attached loop device
- [x] Mounted volume
- [x] Verified using df -h
- [x] Verified using mount | grep devops_data
- [ ] Tested write access
- [ ] Unmounted and cleaned up loop device

## 11. Key Learning

- A mount point is a directory where a filesystem becomes accessible.
- A loop device allows a regular file to behave like a block device.
- ext4 is a commonly used Linux filesystem.
- mount attaches a filesystem to a directory.
- df -h displays disk usage in human-readable format.
- losetup connects image files to loop devices.

## 12. Cleanup (After Practical)

Unmount the volume:

    sudo umount /mnt/devops_data

Detach the loop device:

    sudo losetup -d /dev/loop12

Remove the disk image:

    sudo rm /tmp/devops_volume.img

Note: Replace /dev/loop12 with your actual loop device.
Only clean up after completing verification and ensuring the volume is no longer in use.
