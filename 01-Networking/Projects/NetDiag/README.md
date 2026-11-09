# NetDiag — Network Diagnostics Toolkit

A lightweight Bash-based network diagnostics toolkit designed for Linux servers. NetDiag automates essential network health checks, collects server network information, maintains execution logs, and generates timestamped diagnostic reports.

Built as a hands-on project during my DevOps learning journey.

## Features

- **Internet Connectivity Check:** Uses `ping` to test reachability of a configured target.
- **DNS Resolution Check:** Uses `dig` to verify domain name resolution.
- **HTTP Connectivity Check:** Uses `curl` to inspect HTTP response status codes.
- **Dynamic Configuration:** Loads diagnostic targets from `config/targets.conf`.
- **Server IP Information:** Displays configured IP addresses using `hostname -I`.
- **Default Gateway Information:** Displays the default routing entry using `ip route`.
- **Persistent Logging:** Records diagnostic execution results in `logs/netdiag.log`.
- **Automatic Report Generation:** Creates timestamped reports for each execution.
- **Terminal Output:** Displays results while saving them to report files.

## Project Structure

```text
NetDiag/
├── config/
│   └── targets.conf
├── logs/
│   └── netdiag.log
├── reports/
│   └── netdiag_YYYYMMDD_HHMMSS.txt
├── netdiag.sh
├── .gitignore
└── README.md
```

## Technologies and Tools

- Bash Shell Scripting
- Linux / Ubuntu
- ping
- dig
- curl
- hostname
- iproute2
- tee
- Git and GitHub

## Prerequisites

- Ubuntu or another Linux distribution
- Bash
- curl
- dnsutils (for `dig`)
- iputils-ping (for `ping`)
- iproute2

Install the required packages on Ubuntu:

```bash
sudo apt update
sudo apt install curl dnsutils iputils-ping iproute2 -y
```

## Installation

Clone the repository:

```bash
git clone https://github.com/niraj1234-svg/DevOps-Journey.git
```

Navigate to the project directory:

```bash
cd DevOps-Journey/01-Networking/Projects/NetDiag
```

Make the script executable:

```bash
chmod +x netdiag.sh
```

## Configuration

NetDiag uses `config/targets.conf` to store diagnostic targets.

Example:

```bash
PING_TARGET="google.com"
DNS_TARGET="google.com"
HTTP_TARGET="https://google.com"
```

You can change these targets without modifying the main script.

The script loads the configuration file dynamically using Bash `source`.

## Usage

Run the diagnostic toolkit:

```bash
./netdiag.sh
```

NetDiag performs the following operations:

1. Loads the configured diagnostic targets.
2. Checks internet reachability using ping.
3. Checks DNS resolution using dig.
4. Checks HTTP connectivity using curl.
5. Displays server IP addresses.
6. Displays the default gateway.
7. Saves diagnostic results in a log file.
8. Generates a timestamped diagnostic report.

## Sample Output

```text
NetDiag - Network Diagnostics Toolkit

NetDiag Report - Mon Nov 9 12:50:07 UTC 2026
==============================

PASS: Internet connectivity (google.com)
PASS: DNS resolution (google.com)
PASS: HTTP connectivity (301)

Server IP Address:
172.31.41.112 172.17.0.1

Default Gateway:
default via 172.31.32.1 dev ens5 proto dhcp
```

*Sample output from the development environment.*

## Logging

NetDiag maintains a persistent execution log at:

```text
logs/netdiag.log
```

Example:

```text
NetDiag started at Mon Nov 9 12:50:07 UTC 2026
Mon Nov 9 12:50:08 UTC 2026 | Internet connectivity | PASS
Mon Nov 9 12:50:08 UTC 2026 | DNS resolution | PASS
Mon Nov 9 12:50:09 UTC 2026 | HTTP connectivity | PASS (301)
```

View the latest log entries:

```bash
tail -n 5 logs/netdiag.log
```

## Diagnostic Reports

Every execution generates a separate timestamped report inside:

```text
reports/
```

Example:

```text
netdiag_20261109_125007.txt
```

View available reports:

```bash
ls -lh reports/
```

Read a report:

```bash
cat reports/netdiag_20261109_125007.txt
```

Generated report files are excluded from Git tracking through `.gitignore`.

## Exit Status and Error Handling

NetDiag uses Bash conditional statements and command exit statuses to determine whether checks succeed or fail.

- Exit status `0` generally indicates command success.
- A non-zero exit status indicates failure.
- DNS resolution is checked by examining whether `dig` returns an answer.
- HTTP connectivity is treated as successful when the response status is between 200 and 399.

## Learning Outcomes

Through this project, I practised:

- Linux networking commands.
- Bash scripting and conditional statements.
- Variables and configuration management.
- Command exit statuses and error handling.
- Pipes and output redirection.
- Persistent logging.
- Automated report generation.
- Basic network troubleshooting.
- Git and GitHub project management.

## Future Improvements

- Add configurable multiple diagnostic targets.
- Add response-time measurements.
- Add service and port availability checks.
- Add email or notification alerts.
- Add a scheduled execution option using cron.
- Improve report formatting and summary statistics.

## Author

**Niraj Dhore**

DevOps Learning Journey

GitHub: https://github.com/niraj1234-svg

Repository: https://github.com/niraj1234-svg/DevOps-Journey

---

*NetDiag is an educational network diagnostics project. Its results provide basic connectivity indicators and do not guarantee complete network or service health.*
