#!/bin/bash

echo "NetDiag - Network Diagnostics Toolkit"

REPORT="reports/netdiag_$(date +%Y%m%d_%H%M%S).txt"

mkdir -p reports

exec > >(tee -a "$REPORT") 2>&1

echo "NetDiag Report - $(date)"
echo "=============================="

if ping -c 2 -W 2 google.com >/dev/null 2>&1
then
    echo "PASS: Internet connectivity"
else
    echo "FAIL: Internet connectivity"
fi


if dig +short google.com | grep -q .
then
    echo "PASS: DNS resolution"
else
    echo "FAIL: DNS resolution"
fi

http_code=$(curl -s -o /dev/null -w "%{http_code}" https://google.com)

if [[ "$http_code" -ge 200 && "$http_code" -lt 400 ]]; then
    echo "PASS: HTTP connectivity ($http_code)"
else
    echo "FAIL: HTTP connectivity ($http_code)"
fi

echo "Server IP Address:"
hostname -I

echo "Default Gateway:"
ip route | grep default
