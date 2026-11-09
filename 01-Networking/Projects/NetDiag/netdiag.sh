
#!/bin/bash

echo "NetDiag - Network Diagnostics Toolkit"

# Load configuration
CONFIG="config/targets.conf"

if [[ -f "$CONFIG" ]]; then
    source "$CONFIG"
else
    echo "ERROR: Configuration file not found!"
    exit 1
fi

# Validate configuration
if [[ -z "$PING_TARGET" || -z "$DNS_TARGET" || -z "$HTTP_TARGET" ]]; then
    echo "ERROR: Missing configuration values!"
    exit 1
fi

# Setup log file
LOG_FILE="logs/netdiag.log"
mkdir -p logs reports

echo "NetDiag started at $(date)" >> "$LOG_FILE"

# Generate report
REPORT="reports/netdiag_$(date +%Y%m%d_%H%M%S).txt"
exec > >(tee -a "$REPORT") 2>&1

echo "NetDiag Report - $(date)"
echo "=============================="

# 1. Internet Connectivity
if ping -c 2 -W 2 "$PING_TARGET" > /dev/null 2>&1; then
    echo "PASS: Internet connectivity ($PING_TARGET)"
    echo "$(date) | Internet connectivity | PASS" >> "$LOG_FILE"
else
    echo "FAIL: Internet connectivity ($PING_TARGET)"
    echo "$(date) | Internet connectivity | FAIL" >> "$LOG_FILE"
fi

# 2. DNS Resolution
if dig +short "$DNS_TARGET" | grep -q .; then
    echo "PASS: DNS resolution ($DNS_TARGET)"
    echo "$(date) | DNS resolution | PASS" >> "$LOG_FILE"
else
    echo "FAIL: DNS resolution ($DNS_TARGET)"
    echo "$(date) | DNS resolution | FAIL" >> "$LOG_FILE"
fi

# 3. HTTP Connectivity
http_code=$(curl -s -o /dev/null -w "%{http_code}" "$HTTP_TARGET")

if [[ "$http_code" =~ ^[0-9]{3}$ ]] &&
   [[ "$http_code" -ge 200 && "$http_code" -lt 400 ]]; then
    echo "PASS: HTTP connectivity ($http_code)"
    echo "$(date) | HTTP connectivity | PASS ($http_code)" >> "$LOG_FILE"
else
    echo "FAIL: HTTP connectivity ($http_code)"
    echo "$(date) | HTTP connectivity | FAIL ($http_code)" >> "$LOG_FILE"
fi

# 4. Server Network Information
echo "Server IP Address:"
hostname -I

echo "Default Gateway:"
ip route | grep default

