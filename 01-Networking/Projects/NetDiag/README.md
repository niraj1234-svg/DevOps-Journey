# NetDiag — Network Diagnostics Toolkit

A lightweight Bash-based network diagnostics toolkit for Linux servers. NetDiag automates basic network health checks and generates timestamped diagnostic reports.

## Features

- **Internet Connectivity:** Checks connectivity using `ping`.
- **DNS Resolution:** Verifies DNS resolution using `dig`.
- **HTTP Connectivity:** Checks HTTP response codes using `curl`.
- **IP Information:** Displays server IP addresses using `hostname`.
- **Routing Information:** Displays the default gateway using `ip route`.
- **Automatic Reports:** Saves diagnostic output in timestamped text files.

## Project Structure

```text
NetDiag/
├── config/
├── logs/
├── reports/
├── netdiag.sh
├── .gitignore
└── README.md
```

## Prerequisites

- Linux / Ubuntu
- Bash
- curl
- dnsutils (`dig`)
- iproute2
- ping (`iputils-ping`)

## Installation

```bash
git clone https://github.com/niraj1234-svg/DevOps-Journey.git
cd DevOps-Journey/01-Networking/Projects/NetDiag
chmod +x netdiag.sh
```

## Usage

```bash
./netdiag.sh
```

## Sample Output

```text
NetDiag - Network Diagnostics Toolkit
PASS: Internet connectivity
PASS: DNS resolution
PASS: HTTP connectivity (301)

Server IP Address:
172.31.41.112

Default Gateway:
default via 172.31.32.1 dev ens5
```

## Reports

Every execution generates a timestamped report inside the `reports/` directory.

## Learning Outcomes

- Linux networking commands
- Bash scripting and conditional statements
- Exit-code-based error handling
- Output redirection and logging
- Network troubleshooting automation

## Author

Created as part of my DevOps learning journey.

