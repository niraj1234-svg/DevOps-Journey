4. Hands-On with Networking Commands
Practice essential networking commands like:
ping (check connectivity)
traceroute / tracert (trace packet routes)
netstat (network statistics)
curl (make HTTP requests)
dig / nslookup (DNS lookup)
Task: Create a cheat sheet or short guide explaining the purpose and usage of each command.
Sol:
# Task 4: Hands-On with Networking Commands

## 1. Introduction

Networking commands are essential tools used by DevOps engineers to monitor network connectivity, troubleshoot communication problems, inspect network interfaces, analyze traffic and verify DNS resolution.

This cheat sheet covers commonly used networking commands in Linux and their practical applications.

## 2. Essential Networking Commands

| Command | Purpose | Usage / Example |
|---|---|---|
| `ping` | Checks network connectivity and response time using ICMP. | `ping -c 4 google.com` |
| `traceroute` | Displays the network hops between the source and destination. | `traceroute 8.8.8.8` |
| `tracert` | Windows command for tracing network routes. | `tracert google.com` |
| `netstat` | Displays network connections, listening ports and statistics. | `netstat -tuln` |
| `ss` | Displays socket information and listening ports. Modern alternative to netstat. | `ss -tuln` |
| `curl` | Sends HTTP/HTTPS requests and retrieves responses. | `curl -I https://google.com` |
| `dig` | Queries DNS records of domain names. | `dig google.com` |
| `nslookup` | Retrieves DNS information for a domain. | `nslookup google.com` |

## 3. Additional Important DevOps Networking Commands

### 3.1 Network Interface and Routing Commands

| Command | Purpose | Usage / Example |
|---|---|---|
| `ip addr` | Displays IP addresses assigned to network interfaces. | `ip addr show` |
| `ip link` | Displays network interfaces and their status. | `ip link show` |
| `ip route` | Displays the system routing table. | `ip route` |
| `ip neigh` | Displays the IP-to-link-layer neighbor table. | `ip neigh show` |
| `hostname` | Displays the system hostname. | `hostname` |
| `hostname -I` | Displays assigned IP addresses. | `hostname -I` |

### 3.2 Network Monitoring and Troubleshooting

| Command | Purpose | Usage / Example |
|---|---|---|
| `tracepath` | Traces the network path and helps identify path MTU. | `tracepath google.com` |
| `mtr` | Combines traceroute and continuous network statistics. | `mtr -r -c 5 google.com` |
| `tcpdump` | Captures and analyzes network packets. | `sudo tcpdump -i ens5 -c 10` |
| `iftop` | Displays network bandwidth usage by connections. | `sudo iftop -i ens5` |
| `vnstat` | Monitors network traffic usage over time. | `vnstat` |
| `nc` | Tests TCP/UDP connectivity and transfers data. | `nc -vz google.com 443` |

### 3.3 DNS and Web Connectivity

| Command | Purpose | Usage / Example |
|---|---|---|
| `host` | Performs DNS lookups. | `host google.com` |
| `wget` | Downloads files from web servers. | `wget https://example.com/file.zip` |
| `telnet` | Tests TCP connections to remote services. | `telnet example.com 80` |

### 3.4 Remote Access and Security

| Command | Purpose | Usage / Example |
|---|---|---|
| `ssh` | Provides secure remote access to servers. | `ssh ubuntu@SERVER_IP` |
| `scp` | Securely copies files between systems. | `scp file.txt ubuntu@SERVER_IP:~/` |
| `sftp` | Provides secure interactive file transfer over SSH. | `sftp ubuntu@SERVER_IP` |
| `ufw` | Manages Ubuntu firewall rules. | `sudo ufw status verbose` |
| `iptables` | Inspects and manages Linux firewall rules. | `sudo iptables -L -n -v` |

## 4. Important Command Flags

| Flag | Meaning | Example |
|---|---|---|
| `-c` | Specifies the number of packets for ping. | `ping -c 4 google.com` |
| `-I` | Displays HTTP response headers in curl. | `curl -I https://google.com` |
| `-t` | Displays TCP sockets in ss/netstat. | `ss -t` |
| `-u` | Displays UDP sockets in ss/netstat. | `ss -u` |
| `-l` | Displays listening sockets. | `ss -l` |
| `-n` | Displays numeric addresses and ports. | `ss -n` |
| `-p` | Displays associated processes in ss/netstat. | `sudo ss -p` |
| `-c` | Specifies the packet count in tcpdump. | `sudo tcpdump -c 10` |
| `-i` | Specifies the network interface in tcpdump. | `sudo tcpdump -i ens5` |

## 5. Practical Execution on Ubuntu EC2

The following commands were executed on an Ubuntu EC2 instance.

### 5.1 Ping

Command:

```bash
ping -c 4 google.com
```

Observation:

- 4 packets transmitted.
- 4 packets received.
- Packet loss: 0%.
- Average response time: 3.640 ms.

Result: Network connectivity with Google was successful during the test.

### 5.2 Traceroute

Command:

```bash
traceroute 8.8.8.8
```

Observation:

- The destination was reached in 6 hops.
- The final destination was `8.8.8.8`.
- Intermediate routers were displayed.

Result: Successfully traced the network route to Google's public DNS server.

### 5.3 SS (Socket Statistics)

Command:

```bash
ss -tuln
```

Observation:

The output displayed listening TCP and UDP sockets.

Some identified ports:

| Port | Service / Purpose |
|---:|---|
| 22 | SSH |
| 53 | Local DNS resolver |
| 68 | DHCP client |
| 80 | HTTP |
| 323 | Commonly used by Chrony |

Result: Successfully inspected network sockets and listening ports.

### 5.4 Curl

Command:

```bash
curl https://randomuser.me
```

Observation:

The command returned HTML content from the Random User Generator website.

Result: Successfully established HTTPS communication and retrieved webpage content.

### 5.5 Dig

Command:

```bash
dig google.com
```

Observation:

- DNS status: `NOERROR`.
- Record type: `A`.
- Resolved IP address: `142.251.143.142`.
- Query time: 2 ms.
- DNS server: `127.0.0.53`.

Result: DNS resolution was successful.

## 6. Practical Applications in DevOps

| Real-world problem | Command used |
|---|---|
| Checking server connectivity | `ping` |
| Identifying network routing issues | `traceroute` |
| Checking listening application ports | `ss -tuln` |
| Testing website availability | `curl` |
| Troubleshooting DNS problems | `dig`, `nslookup` |
| Inspecting network interfaces | `ip addr` |
| Checking routing configuration | `ip route` |
| Capturing network traffic | `tcpdump` |
| Testing remote port connectivity | `nc` |
| Inspecting firewall configuration | `ufw`, `iptables` |
| Secure remote server access | `ssh` |
| Transferring files securely | `scp`, `sftp` |

## 7. Safety Considerations

1. Use packet-capturing commands only on networks you are authorized to inspect.
2. Avoid changing routing tables without understanding the impact.
3. Be careful when modifying firewall rules, as incorrect changes can block SSH access.
4. Use trusted IP addresses for remote server access.
5. Avoid running network traffic-generation tools against unauthorized systems.

## 8. Conclusion

Networking commands are essential for DevOps engineers to monitor connectivity, troubleshoot network issues, inspect listening ports, verify DNS resolution and analyze network traffic.

Practising these commands on an Ubuntu EC2 instance provides practical experience with real-world Linux networking and cloud infrastructure.

**Author:** Niraj Dhore  
**Repository:** DevOps Journey  
**Topic:** Networking – Hands-On Networking Commands
