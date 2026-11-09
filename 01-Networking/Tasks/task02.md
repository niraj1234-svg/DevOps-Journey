2. Protocols and Ports for DevOps
Study the most commonly used protocols (e.g., HTTP, HTTPS, FTP, SSH, DNS) and their port numbers.
Task: Create a blog, article, GitHub page, or README listing these protocols and explaining their relevance to DevOps workflows.

Solu :

# Task 2: Protocols and Ports for DevOps

## 1. Introduction

A network protocol is a set of rules that defines how devices communicate and exchange data over a network.

A port number is a logical communication endpoint used to identify a particular application or service.

In DevOps, understanding protocols and ports is important for server administration, application deployment, firewall configuration, network troubleshooting and infrastructure security.

## 2. Common Network Protocols and Port Numbers

| No. | Protocol / Service | Default Port | Transport | Purpose |
|---:|---|---:|---|---|
| 1 | FTP | 20, 21 | TCP | Transfers files between systems. |
| 2 | SSH | 22 | TCP | Provides secure remote access to servers. |
| 3 | SFTP | 22 | TCP | Transfers files securely over SSH. |
| 4 | SMTP | 25 | TCP | Transfers emails between mail servers. |
| 5 | DNS | 53 | UDP/TCP | Resolves domain names into IP addresses. |
| 6 | DHCP | 67, 68 | UDP | Automatically assigns IP addresses and network configurations. |
| 7 | HTTP | 80 | TCP | Transfers web requests and responses. |
| 8 | POP3 | 110 | TCP | Retrieves emails from a mail server. |
| 9 | NTP | 123 | UDP | Synchronizes system clocks across devices. |
| 10 | IMAP | 143 | TCP | Accesses and manages emails on a mail server. |
| 11 | HTTPS | 443 | TCP | Secures HTTP communication using TLS. |
| 12 | SMTP Submission | 587 | TCP | Submits outgoing emails, commonly using STARTTLS. |
| 13 | MySQL | 3306 | TCP | Provides connectivity to MySQL databases. |
| 14 | PostgreSQL | 5432 | TCP | Provides connectivity to PostgreSQL databases. |
| 15 | Redis | 6379 | TCP | Provides access to Redis data services. |
| 16 | Jenkins | 8080 | TCP | Provides access to the Jenkins web interface by default. |
| 17 | Grafana | 3000 | TCP | Provides monitoring dashboards and visualization. |
| 18 | Prometheus | 9090 | TCP | Provides metrics querying and monitoring interfaces. |
| 19 | Node Exporter | 9100 | TCP | Exposes Linux system metrics for Prometheus. |
| 20 | Kubernetes API Server | 6443 | TCP | Provides access to the Kubernetes cluster management API. |
| 21 | MongoDB | 27017 | TCP | Provides connectivity to MongoDB databases. |

**Note:** These are default ports. Services can be configured to use different ports. FTP uses TCP 21 for control and TCP 20 for data in active mode. Passive FTP uses negotiated data ports. HTTPS can also operate over HTTP/3 using QUIC on UDP port 443.

## 3. Explanation of Important Protocols

### 3.1 HTTP (Port 80)

HTTP stands for Hypertext Transfer Protocol.

- Transfers data between web browsers and web servers.
- Uses a request-response communication model.
- Does not provide encryption by itself.

**Real-world example:** Accessing a website through a browser.

### 3.2 HTTPS (Port 443)

HTTPS stands for Hypertext Transfer Protocol Secure.

- Uses HTTP communication protected by TLS.
- Provides encryption, authentication and integrity protection.
- Protects sensitive information during transmission.

**Real-world example:** Securely logging into a website.

### 3.3 FTP (Ports 20 and 21)

FTP stands for File Transfer Protocol.

- Transfers files between a client and a server.
- Uses port 21 for control communication.
- Uses port 20 for data transfer in active mode.
- Standard FTP does not encrypt credentials or data.

**Real-world example:** Transferring files between systems.

### 3.4 SSH (Port 22)

SSH stands for Secure Shell.

- Provides secure remote access to servers.
- Supports password and public-key authentication.
- Encrypts communication between the client and server.

**Real-world example:** Connecting to an AWS EC2 Ubuntu instance.

### 3.5 SFTP (Port 22)

SFTP stands for SSH File Transfer Protocol.

- Provides secure file transfer over SSH.
- Supports uploading, downloading and managing remote files.
- Uses SSH authentication and encryption.

**Real-world example:** Uploading application files to a remote server.

### 3.6 DNS (Port 53)

DNS stands for Domain Name System.

- Resolves human-readable domain names into IP addresses.
- Helps clients locate servers using domain names.
- Uses both UDP and TCP.

**Real-world example:** Resolving `google.com` into an IP address.

### 3.7 DHCP (Ports 67 and 68)

DHCP stands for Dynamic Host Configuration Protocol.

- Automatically assigns IP addresses to devices.
- Provides network configuration such as subnet masks, gateways and DNS servers.
- Uses UDP port 67 for the server and UDP port 68 for the client.

**Real-world example:** An EC2 instance receiving its network configuration through DHCP.

### 3.8 NTP (Port 123)

NTP stands for Network Time Protocol.

- Synchronizes system clocks across networked devices.
- Helps maintain accurate timestamps.
- Supports consistent logging and monitoring.

**Real-world example:** Synchronizing time across multiple application servers.

## 4. DevOps Tools and Their Ports

| Service | Default Port | Purpose | Real-world example |
|---|---:|---|---|
| Jenkins | 8080 | CI/CD automation interface. | Managing build and deployment pipelines. |
| Prometheus | 9090 | Metrics monitoring and querying. | Monitoring server CPU and memory usage. |
| Grafana | 3000 | Metrics visualization and dashboards. | Viewing infrastructure monitoring dashboards. |
| Node Exporter | 9100 | Exposes Linux system metrics. | Prometheus collecting EC2 metrics. |
| Kubernetes API Server | 6443 | Kubernetes cluster management API. | `kubectl` communicating with the cluster. |

## 5. Relevance of Protocols and Ports in DevOps

Understanding protocols and ports helps DevOps engineers in:

1. **Remote Server Management:** SSH allows engineers to connect securely to remote servers.
2. **Application Deployment:** HTTP and HTTPS allow users to access deployed applications.
3. **DNS Configuration:** DNS connects domain names to application servers.
4. **Database Connectivity:** MySQL, PostgreSQL and MongoDB ports allow backend applications to communicate with databases.
5. **CI/CD Automation:** Jenkins provides an interface for managing automated build and deployment pipelines.
6. **Monitoring:** Prometheus and Grafana help monitor infrastructure and application performance.
7. **Security:** Firewall and AWS Security Group rules control which network connections are allowed.

## 6. Real-World DevOps Example: Deploying a Web Application on AWS EC2

Suppose a DevOps engineer deploys a web application on an Ubuntu EC2 instance.

The following ports may be required:

| Port | Service | Purpose |
|---:|---|---|
| 22 | SSH | Remote server administration. |
| 80 | HTTP | Public website access. |
| 443 | HTTPS | Secure website access. |
| 3306 | MySQL | Database connectivity, if MySQL is used. |

The engineer configures AWS Security Groups to allow only the necessary network traffic.

SSH access should be restricted to trusted IP addresses, and database ports should not be exposed publicly.

## 7. Security Best Practices

- Open only the ports required by the application.
- Restrict SSH access to trusted IP addresses.
- Prefer SFTP or FTPS over unencrypted FTP for sensitive file transfers.
- Use HTTPS to protect web communication.
- Avoid exposing database ports directly to the public Internet.
- Regularly review firewall and Security Group rules.
- Monitor unexpected network connections.

## 8. Conclusion

Network protocols and port numbers are fundamental to communication between devices, applications and servers.

For DevOps engineers, understanding these protocols is essential for server administration, cloud infrastructure, application deployment, network troubleshooting and security.

Knowing what each protocol does, which port it uses and where it is applied helps engineers build reliable and secure infrastructure.

**Author:** Niraj Dhore  
**Repository:** DevOps Journey  
**Topic:** Networking – Protocols and Ports for DevOps
