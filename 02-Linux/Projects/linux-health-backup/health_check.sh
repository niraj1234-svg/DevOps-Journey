
#!/bin/bash

# ==========================================
# LINUX SERVER HEALTH CHECK SCRIPT
# ==========================================

# Current system information
HOSTNAME=$(hostname)
CURRENT_DATE=$(date "+%d-%m-%Y %H:%M:%S")
SYSTEM_UPTIME=$(uptime -p)

# CPU information
CPU_CORES=$(nproc)
read -r LOAD_1 LOAD_5 LOAD_15 _ < /proc/loadavg

# Memory information
MEMORY_INFO=$(free -h | awk 'NR==2 {printf "Total: %s | Used: %s | Available: %s", $2, $3, $7}')

# Disk information
DISK_INFO=$(df -h / | awk 'NR==2 {printf "Total: %s | Used: %s | Free: %s | Usage: %s", $2, $3, $4, $5}')

# Top 5 memory-consuming processes
TOP_PROCESSES=$(ps -eo pid,comm,%mem,%cpu --sort=-%mem | head -n 6)

# Display report
echo "=========================================="
echo "         LINUX SERVER HEALTH REPORT"
echo "=========================================="

echo ""
echo "SYSTEM INFORMATION"
echo "Hostname       : $HOSTNAME"
echo "Date & Time    : $CURRENT_DATE"
echo "System Uptime  : $SYSTEM_UPTIME"

echo ""
echo "CPU INFORMATION"
echo "CPU Cores      : $CPU_CORES"
echo "Load Average   : 1 min: $LOAD_1 | 5 min: $LOAD_5 | 15 min: $LOAD_15"

echo ""
echo "MEMORY INFORMATION"
echo "$MEMORY_INFO"

echo ""
echo "DISK INFORMATION"
echo "$DISK_INFO"

echo ""
echo "TOP 5 MEMORY-CONSUMING PROCESSES"
echo "$TOP_PROCESSES"

echo ""
echo "=========================================="
echo "         HEALTH CHECK COMPLETED"
echo "=========================================="

