# DEVOPS JOURNEY — NETWORKING REVISION NOTES

**Revision baseline:** 12 November 2026  
**Project:** NetDiag  
**Environment:** Ubuntu on AWS EC2

---

# 1. NETWORKING FUNDAMENTALS

## 1.1 What is Computer Networking?

Computer networking is the process of connecting two or more devices so that they can communicate and exchange data.

**Why do we need networking?**
- Communication between computers.
- Sharing files and resources.
- Accessing websites and applications.
- Connecting servers and cloud infrastructure.
- Remote server management.

**Real-world example:** When we access Google from our laptop, our laptop communicates with Google's servers through a network.

## 1.2 Client and Server

**Client:** A device or application that requests a service.

**Server:** A computer or application that receives requests and provides responses.

Example:
- Browser = Client
- Google server = Server

Basic communication:

Client → Request → Server  
Client ← Response ← Server

---

# 2. IP ADDRESS

## 2.1 What is an IP Address?

An IP address is a logical address assigned to a network interface to identify it and enable communication over an IP network.

Two commonly used IP versions:

- IPv4: 32-bit address.
- IPv6: 128-bit address.

Examples:

IPv4: `192.168.1.10`

IPv6: `2001:db8::1`

## 2.2 Public IP vs Private IP

| Public IP | Private IP |
|---|---|
| Routable over the public internet | Used within private networks |
| Used for direct internet communication | Used for internal communication |
| Globally unique while assigned | Unique within its network scope |
| Can be used to access public-facing servers | Used for internal server communication |

Private IPv4 address ranges:

- `10.0.0.0/8`
- `172.16.0.0/12`
- `192.168.0.0/16`

**Important:** Private IP does not mean secret or confidential. It means the address is not directly routable over the public internet.

### AWS Example

An EC2 instance may have:
- Public IP: Used for internet communication.
- Private IP: Used for communication within its VPC.

Two EC2 instances in the same VPC can communicate using private IPs when routing and security rules permit it.

An EC2 instance does not necessarily need a public IP if accessed through a VPN, bastion host or AWS Systems Manager.

---

# 3. CIDR AND SUBNETTING

## 3.1 What is CIDR?

CIDR stands for Classless Inter-Domain Routing.

It represents an IP network using an IP address followed by a prefix length.

Example:

`192.168.1.0/24`

Here:
- `192.168.1.0` = Network address.
- `/24` = 24 bits represent the network portion.
- Remaining 8 bits represent the host portion.

For IPv4:

Total bits = 32

Host bits = 32 - Prefix length

For `/24`:

- Network bits = 24
- Host bits = 8
- Total addresses = 2^8 = 256
- Traditionally usable host addresses = 254

**Important:** AWS reserves five IPv4 addresses in every subnet, so a `/24` AWS subnet has 251 available IP addresses for resources.

## 3.2 Why do we use subnetting?

Subnetting divides a larger network into smaller networks.

Benefits:
- Better IP address management.
- Network segmentation.
- Improved security.
- Efficient resource allocation.

**AWS example:** A VPC can contain multiple subnets, such as public and private subnets.

---

# 4. ROUTING

## 4.1 What is Routing?

Routing is the process of forwarding network packets from a source network to a destination network using routing information.

A router examines the destination IP address and selects the appropriate next hop.

## 4.2 Default Gateway

A default gateway is the router used when a destination does not match a more specific route in the routing table.

Example:

`192.168.1.1`

## 4.3 Routing Table

A routing table stores information about available network routes.

Command:

`ip route`

Example:

`default via 172.31.0.1 dev ens5`

Meaning:
- `default` = Default route.
- `via 172.31.0.1` = Next-hop gateway.
- `dev ens5` = Network interface.

Useful commands:

`ip route`

`ip route get 8.8.8.8`

`ip addr`

`ip -4 addr show ens5`

## 4.4 Traceroute

Traceroute shows the network path taken by packets toward a destination.

Commands:

`traceroute google.com`

`tracepath google.com`

It helps identify intermediate hops and possible network path problems.

**Remember:** Traceroute is not the same as `ss`. Traceroute examines network paths; `ss` examines sockets and connections.

---

# 5. DNS — DOMAIN NAME SYSTEM

## 5.1 What is DNS?

DNS stands for Domain Name System.

It translates domain names into IP addresses so that clients can locate servers.

Example:

`google.com` → Corresponding IP address

DNS works like the phonebook of the internet.

## 5.2 DNS Resolution Process

When a user enters `google.com`:

1. Browser checks its DNS cache.
2. Operating system may check its DNS cache.
3. If no valid cached answer exists, a DNS query goes to a recursive resolver.
4. The resolver may contact root, TLD and authoritative DNS servers.
5. The authoritative server provides the requested DNS record.
6. The resolver returns the answer to the client.
7. The answer may be cached for its TTL.

## 5.3 Important DNS Record Types

| Record | Purpose |
|---|---|
| A | Maps domain to IPv4 address |
| AAAA | Maps domain to IPv6 address |
| CNAME | Maps one domain name to another |
| MX | Specifies mail servers |
| NS | Identifies authoritative name servers |
| TXT | Stores text information, often used for verification |

## 5.4 DNS Troubleshooting

Commands:

`dig google.com`

`nslookup google.com`

`host google.com`

Query a specific DNS resolver:

`dig @8.8.8.8 google.com`

Check DNS configuration:

`cat /etc/resolv.conf`

### Scenario

Error:

`ping: google.com: Temporary failure in name resolution`

Possible cause: DNS resolution failure.

To differentiate DNS failure from general internet connectivity failure:

1. Test IP connectivity:

`ping -c 4 8.8.8.8`

2. Test normal DNS resolution:

`dig google.com`

3. Test an external DNS resolver:

`dig @8.8.8.8 google.com`

Interpretation:

- IP connectivity works but DNS fails: likely DNS issue.
- Both fail: possible network connectivity or routing issue.
- External resolver works but configured resolver fails: likely configured DNS resolver issue.

---

# 6. DHCP

## 6.1 What is DHCP?

DHCP stands for Dynamic Host Configuration Protocol.

It automatically provides network configuration to clients.

It can provide:
- IP address.
- Subnet mask.
- Default gateway.
- DNS server information.
- Lease duration.

## 6.2 DORA Process

DHCP commonly uses four steps:

1. Discover — Client searches for a DHCP server.
2. Offer — Server offers an IP address.
3. Request — Client requests the offered address.
4. Acknowledge — Server confirms the allocation.

Remember: DORA = Discover, Offer, Request, Acknowledge.

---

# 7. TCP VS UDP

## 7.1 TCP

TCP stands for Transmission Control Protocol.

Characteristics:
- Connection-oriented.
- Reliable delivery.
- Ordered data delivery.
- Uses acknowledgements.
- Retransmits lost data.

Common examples:
- SSH.
- HTTPS over HTTP/1.1 or HTTP/2.
- Traditional file transfers.

## 7.2 UDP

UDP stands for User Datagram Protocol.

Characteristics:
- Connectionless.
- No built-in delivery guarantee.
- No built-in ordering guarantee.
- Lower protocol overhead.

Common examples:
- DNS queries.
- Real-time voice and video.
- Online gaming.

## 7.3 Comparison

| TCP | UDP |
|---|---|
| Connection-oriented | Connectionless |
| Reliable delivery | No built-in reliability guarantee |
| Ordered delivery | No built-in ordering |
| Acknowledgements and retransmission | No built-in acknowledgements or retransmission |
| More protocol overhead | Less protocol overhead |

**Interview point:** Real-time applications may prefer UDP because they often value low latency over retransmitting every lost packet.

Important exception: Modern HTTP/3 uses QUIC over UDP, whereas HTTP/1.1 and HTTP/2 commonly use TCP.

---

# 8. SSH AND SCP

## 8.1 SSH

SSH stands for Secure Shell.

It provides secure remote access to another machine over an encrypted connection.

Default port: TCP 22.

Example:

`ssh ubuntu@YOUR_EC2_PUBLIC_IP`

Here:
- `ssh` = SSH client command.
- `ubuntu` = Remote username.
- Public IP = Remote server address.

## 8.2 SCP

SCP stands for Secure Copy Protocol.

It is used to transfer files between local and remote machines over SSH.

Upload:

`scp file.txt ubuntu@SERVER_IP:/home/ubuntu/`

Download:

`scp ubuntu@SERVER_IP:/home/ubuntu/file.txt .`

Copy a directory:

`scp -r folder/ ubuntu@SERVER_IP:/home/ubuntu/`

---

# 9. HTTP AND HTTPS

## 9.1 HTTP

HTTP stands for Hypertext Transfer Protocol.

It is an application-layer protocol used for communication between clients and servers.

The client sends an HTTP request and receives an HTTP response.

## 9.2 HTTPS

HTTPS is HTTP secured using TLS.

It provides:
- Confidentiality through encryption.
- Integrity protection.
- Server authentication using certificates.

## 9.3 TLS

TLS stands for Transport Layer Security.

TLS establishes a secure communication channel between the client and server.

During the TLS handshake:
1. Client and server negotiate security parameters.
2. Server presents its certificate.
3. Client verifies the server's identity.
4. Both sides establish shared encryption keys.

## 9.4 HTTP vs HTTPS

| HTTP | HTTPS |
|---|---|
| No transport encryption by default | Protected using TLS |
| Data can be read if intercepted | Application data is encrypted |
| No TLS certificate required | TLS certificate used |
| Common default port 80 | Common default port 443 |

## 9.5 Browser Request Lifecycle

When entering:

`https://google.com`

Typical HTTP/1.1 or HTTP/2 flow:

1. Browser resolves the domain through DNS.
2. TCP connection is established.
3. TLS handshake takes place.
4. Browser sends an HTTP request.
5. Server processes the request.
6. Server sends an HTTP response.
7. Browser processes resources and renders the page.

Important: HTTP/3 uses QUIC over UDP instead of TCP.

---

# 10. NETWORKING COMMANDS

## 10.1 Important Linux Commands

| Command | Purpose |
|---|---|
| `ip addr` | Display IP addresses |
| `ip route` | Display routing table |
| `ip route get IP` | Show route selected for a destination |
| `ping` | Test reachability |
| `dig` | DNS queries |
| `nslookup` | DNS lookup |
| `traceroute` | Trace network path |
| `ss` | Inspect sockets |
| `curl` | Make HTTP requests |
| `hostname -I` | Display host IP addresses |
| `cat /etc/resolv.conf` | Inspect resolver configuration |
| `nc` | Test TCP/UDP connectivity |

## 10.2 Understanding ss

Command:

`ss -tulnp`

Meaning:

| Flag | Meaning |
|---|---|
| `-t` | TCP sockets |
| `-u` | UDP sockets |
| `-l` | Listening sockets |
| `-n` | Numeric addresses and ports |
| `-p` | Process information |

Find process listening on port 8080:

`sudo ss -tulnp | grep :8080`

Example interpretation:

`users:(("node",pid=1234,fd=20))`

- `node` = Process name.
- `1234` = Process ID.
- `20` = File descriptor.

---

# 11. FIREWALL AND NETWORK SECURITY

## 11.1 What is a Firewall?

A firewall controls network traffic according to configured security rules.

It can allow or block traffic based on addresses, ports and protocols.

## 11.2 Inbound and Outbound Traffic

**Inbound:** Traffic entering a server or network.

**Outbound:** Traffic leaving a server or network.

Example:
- Inbound SSH: TCP port 22.
- Inbound HTTP: TCP port 80.
- Inbound HTTPS: TCP port 443.

## 11.3 Ubuntu UFW

Check firewall status:

`sudo ufw status`

Allow SSH:

`sudo ufw allow 22/tcp`

Allow HTTP:

`sudo ufw allow 80/tcp`

Allow HTTPS:

`sudo ufw allow 443/tcp`

**Caution:** Before enabling UFW on a remote server, ensure SSH access is allowed to avoid locking yourself out.

---

# 12. AWS NETWORKING

## 12.1 VPC

VPC stands for Virtual Private Cloud.

It provides a logically isolated network in AWS where we can launch resources.

## 12.2 Subnets

A subnet is a range of IP addresses inside a VPC.

Subnets can be configured as public or private depending on their routing and architecture.

## 12.3 Internet Gateway

An Internet Gateway enables communication between a VPC and the internet, subject to routing and security configuration.

A public subnet generally has a route such as:

`0.0.0.0/0 → Internet Gateway`

## 12.4 Security Group

A Security Group is a stateful virtual firewall associated with an EC2 network interface.

Characteristics:
- Supports allow rules.
- No explicit deny rules.
- Stateful: return traffic is automatically permitted for an allowed connection.

## 12.5 Network ACL

A Network ACL is a stateless firewall associated with a subnet.

Characteristics:
- Supports allow and deny rules.
- Evaluates rules in ascending rule-number order.
- Inbound and outbound rules are evaluated separately.
- Return traffic must be explicitly allowed.

## 12.6 Security Group vs NACL

| Security Group | NACL |
|---|---|
| Attached to network interface | Attached to subnet |
| Stateful | Stateless |
| Allow rules only | Allow and deny rules |
| Return traffic automatically allowed | Return traffic must be allowed separately |

---

# 13. REAL-WORLD TROUBLESHOOTING

## Scenario 1: DNS Failure

Error:

`Temporary failure in name resolution`

Troubleshooting:

1. `ping -c 4 8.8.8.8`
2. `dig google.com`
3. `dig @8.8.8.8 google.com`
4. `cat /etc/resolv.conf`
5. Inspect network configuration and DNS resolver availability.

## Scenario 2: EC2 Application Works Locally but Not Externally

Situation:

- Node.js application runs on port 3000.
- `curl localhost:3000` works.
- Public IP access fails.

Possible causes:

1. Application listens only on `127.0.0.1`.
2. Security Group does not allow inbound TCP 3000.
3. UFW blocks the port.
4. Subnet routing or network ACL issue.
5. Public IP or internet gateway configuration problem.

Useful commands:

`sudo ss -tulnp | grep :3000`

`sudo ufw status`

`curl -v http://YOUR_EC2_PUBLIC_IP:3000`

An externally accessible application normally needs to bind to `0.0.0.0` or its appropriate interface address, with network access configured correctly.

## Scenario 3: SSH Connection Timeout

Command:

`ssh ubuntu@YOUR_EC2_PUBLIC_IP`

Possible causes:

1. Incorrect Security Group inbound source IP.
2. Missing public IP.
3. NACL blocking inbound TCP 22.
4. NACL blocking outbound return traffic.
5. Missing route to Internet Gateway.
6. Local network or ISP blocking port 22.
7. SSH service or host networking issue.

Useful commands:

Local machine:

`nc -vz YOUR_EC2_PUBLIC_IP 22`

On EC2, using an alternative access method:

`sudo systemctl status ssh`

`sudo ss -tulnp | grep :22`

Important: Connection timeout usually indicates that the connection attempt is not receiving a response. It does not by itself prove which component is responsible.

---

# 14. NETDIAG PROJECT

## Project Objective

Build a Bash-based network diagnostic utility for Ubuntu.

## Features Implemented

- Ping connectivity check.
- DNS resolution check using `dig`.
- HTTP connectivity check using `curl`.
- Server IP detection using `hostname -I`.
- Default route detection using `ip route`.
- Dynamic targets using configuration file.
- Persistent logging.
- Timestamped diagnostic reports.

## Project Structure

```text
NetDiag/
├── netdiag.sh
├── config/
│   └── targets.conf
├── logs/
│   └── netdiag.log
├── reports/
├── .gitignore
└── README.md
```

## GitHub Status

Repository:

https://github.com/niraj1234-svg/DevOps-Journey

Branch:

`ball-game`

Last recorded successful push:

`fb98188..be0312d`

NetDiag is our first documented DevOps portfolio project.

---

# 15. QUICK INTERVIEW REVISION

1. TCP vs UDP: TCP is reliable and connection-oriented; UDP is connectionless with no built-in delivery guarantee.
2. DNS: Resolves domain names into IP addresses.
3. DHCP: Automatically assigns network configuration using DORA.
4. CIDR: Represents network prefixes and address ranges.
5. Routing: Determines where packets should be forwarded.
6. SSH: Secure remote access, commonly TCP port 22.
7. SCP: Secure file transfer over SSH.
8. HTTP: Application-layer communication protocol.
9. HTTPS: HTTP secured using TLS.
10. TLS: Provides confidentiality, integrity and authentication.
11. Public IP: Internet-routable address.
12. Private IP: Used for private network communication.
13. Firewall: Controls network traffic.
14. Security Group: Stateful AWS network-interface firewall.
15. NACL: Stateless subnet-level firewall.
16. `ss`: Inspects sockets and listening ports.
17. `traceroute`: Shows network path and intermediate hops.
18. `dig`: Performs DNS queries.
19. `curl`: Makes HTTP requests and tests HTTP connectivity.
20. `ip route`: Displays routing information.

---

# 16. REVISION CHECKLIST

- [ ] Explain DNS resolution without notes.
- [ ] Explain TCP three-way handshake.
- [ ] Differentiate TCP and UDP.
- [ ] Explain CIDR and subnetting.
- [ ] Read and interpret `ip route`.
- [ ] Explain DHCP DORA.
- [ ] Explain SSH and SCP.
- [ ] Explain TLS handshake at a high level.
- [ ] Differentiate Security Group and NACL.
- [ ] Troubleshoot DNS failure.
- [ ] Troubleshoot EC2 application connectivity.
- [ ] Troubleshoot SSH timeout.
- [ ] Re-run and explain the NetDiag script.

**Revision rule:** Don't just reread these notes. Close the document, explain each topic from memory, then reopen it to identify gaps.

**Scope note:** This notebook consolidates topics evidenced in our available Networking discussions. The exact contents of Networking Parts 1 and 2, and some lecture-specific material from Parts 3–5, still need to be added from your original notes or course material.
