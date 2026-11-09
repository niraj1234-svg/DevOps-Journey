3. AWS EC2 and Security Groups
Launch an AWS EC2 instance (free tier is fine).
Learn about Security Groups, their rules, and their significance in securing cloud instances.
Task: Write a step-by-step guide or blog on how to create and configure Security Groups.
sol:

# Task 3: AWS EC2 and Security Groups

## 1. Objective

To launch an AWS EC2 instance, understand Security Groups, configure inbound and outbound rules, and secure access to the cloud server.

## 2. What is AWS EC2?

Amazon EC2 (Elastic Compute Cloud) is an AWS service that provides virtual servers in the cloud.

**Real-world example:** A DevOps engineer uses EC2 to host websites, applications and backend services.

## 3. What is a Security Group?

A Security Group acts as a virtual firewall that controls incoming and outgoing traffic for an EC2 instance.

Security Groups are **stateful**, meaning response traffic for an allowed connection is automatically permitted.

### Types of Security Group Rules

- **Inbound rules:** Control traffic entering the EC2 instance.
- **Outbound rules:** Control traffic leaving the EC2 instance.

## 4. Steps to Launch an EC2 Instance

1. Sign in to the AWS Management Console.
2. Search for **EC2** and open the EC2 dashboard.
3. Click **Launch instance**.
4. Enter an instance name, such as `DevOps-Networking`.
5. Under **Application and OS Images (AMI)**, select Ubuntu Server.
6. Under **Instance type**, select a free-tier-eligible instance type for your account, if available.
7. Create or select an SSH key pair and securely save the private key.
8. Under **Network settings**, select the required VPC and subnet.
9. Configure storage according to your requirements.
10. Select the number of instances (1).
11. Review the configuration and click **Launch instance**.

**Note:** Check the AWS pricing and Free Tier eligibility displayed for your account before launching.

## 5. Steps to Create a Security Group

1. Open the AWS EC2 dashboard.
2. From the left menu, select **Network & Security → Security Groups**.
3. Click **Create security group**.
4. Enter the following details:
   - Security group name: `DevOps-Web-SG`
   - Description: `Security group for DevOps web server`
   - VPC: Select the same VPC as your EC2 instance.
5. Configure the inbound and outbound rules.
6. Click **Create security group**.

## 6. Configure Inbound Rules

Inbound rules determine which traffic can enter the instance.

| Type | Protocol | Port | Source | Purpose |
|---|---|---|---|---|
| SSH | TCP | 22 | My IP (`/32`) | Secure remote access |
| HTTP | TCP | 80 | `0.0.0.0/0` | Public website access |
| HTTPS | TCP | 443 | `0.0.0.0/0` | Secure website access |

**Security note:** SSH should be restricted to your trusted public IP address rather than allowing access from the entire Internet.

HTTP and HTTPS rules are needed only when hosting a publicly accessible web service.

## 7. Configure Outbound Rules

Outbound rules control traffic leaving the instance.

For a basic learning setup, the default outbound rule often allows all traffic:

| Type | Protocol | Destination | Purpose |
|---|---|---|---|
| All traffic | All | `0.0.0.0/0` | Allows outgoing IPv4 connections |

In production, outbound rules should be restricted according to application requirements.

## 8. Attach the Security Group to an EC2 Instance

1. Open **EC2 → Instances**.
2. Select your instance.
3. Choose **Actions → Security → Change security groups**.
4. Select the new `DevOps-Web-SG` Security Group.
5. Ensure all necessary existing access rules remain available.
6. Save the changes.

An EC2 network interface can have multiple Security Groups. Their allowed rules are combined.

## 9. Verify the Configuration

### Test SSH Access

From your local terminal:

```bash
chmod 400 key.pem
ssh -i key.pem ubuntu@PUBLIC_IP
```

Replace `key.pem` with your private key filename and `PUBLIC_IP` with the instance's public IP address.

### Check Listening Ports

Inside Ubuntu:

```bash
sudo ss -tulnp
```

This displays listening TCP/UDP ports and associated processes.

### Test HTTP

If a web server is installed and running:

```bash
curl -I http://PUBLIC_IP
```

**Important:** Allowing port 80 in a Security Group does not automatically start a web server. The application must be running and listening on that port.

## 10. Why Security Groups Are Important

1. Prevent unauthorized network access.
2. Restrict sensitive ports such as SSH.
3. Control application traffic.
4. Reduce the attack surface of cloud infrastructure.
5. Help enforce least-privilege network access.

## 11. Security Best Practices

- Restrict SSH access to trusted IP addresses.
- Open only required ports.
- Avoid exposing database ports publicly.
- Regularly review Security Group rules.
- Use HTTPS for public web applications.
- Remove unused rules.
- Remember that Security Groups are stateful and use allow rules, not explicit deny rules.

## 12. Conclusion

AWS Security Groups provide an essential network security layer for EC2 instances.

By configuring inbound and outbound rules correctly, DevOps engineers can control server access, protect applications and reduce unnecessary network exposure.

**Learning outcome:** Understanding EC2 deployment, Security Group configuration, network ports and cloud security fundamentals.
