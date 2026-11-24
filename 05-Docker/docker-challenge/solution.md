# Docker Challenge Project

## Task 1: Introduction and Conceptual Understanding

### 1. Introduction to Docker

Docker is an open-source platform used to build, package, distribute, and run applications inside lightweight containers.

In modern DevOps, Docker helps developers create consistent application environments across development, testing, and production.

It solves the common problem of "It works on my machine" by packaging an application along with its required dependencies and configuration.

**Importance of Docker in DevOps:**
- Provides application portability.
- Ensures consistency across environments.
- Simplifies application deployment.
- Supports microservices architecture.
- Improves CI/CD pipeline efficiency.
- Makes application scaling easier.

### 2. Virtualization vs Containerization

| Virtualization | Containerization |
|---|---|
| Runs multiple Virtual Machines. | Runs multiple containers. |
| Each VM has its own Guest OS. | Containers share the host OS kernel. |
| Requires more system resources. | Generally lightweight and resource-efficient. |
| Takes more time to start. | Starts quickly. |
| Each VM has a separate OS environment. | Applications run in isolated container environments. |

### 3. Why Containerization is Preferred

Containerization is especially useful for microservices and CI/CD pipelines because:

1. **Lightweight:** Containers use fewer resources than traditional virtual machines.
2. **Portability:** Applications can run consistently across different environments.
3. **Fast Deployment:** Containers can start and stop quickly.
4. **Isolation:** Each microservice can run independently.
5. **Scalability:** Individual services can be scaled separately.
6. **CI/CD Integration:** Containers make it easier to build, test, and deploy applications automatically.

### Conclusion

Docker simplifies modern software development by providing portability, consistency, isolation, and faster deployment. It is an important technology in modern DevOps practices.


## Task 3: Docker Terminologies and Components

### 1. Important Docker Terminologies

**1. Docker Image**

A Docker image is a read-only template containing application code, dependencies, libraries, and configuration required to run a container.

**2. Docker Container**

A container is a running instance of a Docker image. It provides an isolated environment for executing an application.

**3. Dockerfile**

A Dockerfile is a text file containing instructions used to build a Docker image.

**4. Docker Volume**

A Docker volume is a persistent storage mechanism used to store data outside a container's writable layer. Data can survive container removal.

**5. Docker Network**

Docker networks allow containers to communicate with each other and external systems.

### 2. Main Docker Components

**1. Docker Client**

The Docker Client is the command-line interface used to communicate with the Docker Daemon through Docker commands.

**2. Docker Daemon**

The Docker Daemon (`dockerd`) manages Docker objects such as images, containers, networks, and volumes.

**3. Docker Engine**

Docker Engine is the core containerization technology. It includes the Docker Daemon, REST API, and Docker CLI.

**4. Docker Registry**

A Docker Registry stores and distributes Docker images.

**5. Docker Hub**

Docker Hub is a cloud-based public and private Docker image registry.

**6. Docker Compose**

Docker Compose is a tool used to define and manage multi-container applications through a YAML configuration file.

### 3. How Docker Components Interact

1. The user enters a command using the Docker Client.
2. The Docker Client sends a request to the Docker Daemon through the Docker API.
3. The Docker Daemon performs the requested operation.
4. If an image is unavailable locally, Docker can pull it from a registry such as Docker Hub.
5. The Docker Daemon creates and manages containers using the downloaded image.

### Conclusion

Docker components work together to simplify application packaging, distribution, deployment, networking, and storage management.
### Task 4: Multi-Stage Docker Build

A multi-stage Docker build uses multiple stages in a single Dockerfile. It allows us to separate the build environment from the final runtime environment.

**Implementation:**
- Stage 1: Used Node.js Alpine to install production dependencies and prepare the application.
- Stage 2: Used a Distroless Node.js runtime image.
- Copied only the prepared application files from the builder stage.
- Configured the final container to run as a non-root user.

**Image Size Comparison:**

| Metric | Original Image | Multi-Stage Image |
|---|---:|---:|
| Image | latest | v2 |
| Disk Usage | 257 MB | 217 MB |
| Content Size | 64.3 MB | 55.4 MB |

**Content size reduction:** Approximately 13.8%.

**Benefits:**
1. Separates build and runtime environments.
2. Excludes unnecessary build tools from the final image.
3. Uses a minimal Distroless runtime.
4. Reduces the final image size.
5. Improves security by reducing the attack surface and running as a non-root user.

**Conclusion:**

The multi-stage build produced a smaller and more minimal image than the original build. Further optimization can be explored by reviewing application dependencies and runtime requirements.


### Task 5: Manage Image with Docker Hub

**Docker Hub Repository:** nirajdhore/sample-app

**Steps performed:**

1. Tagged the optimized multi-stage image as `nirajdhore/sample-app:v1.0`.
2. Authenticated with Docker Hub using `docker login`.
3. Uploaded the image using `docker push`.
4. Verified the repository and v1.0 tag in Docker Hub.

**Published Image Details:**

- Repository: `nirajdhore/sample-app`
- Tag: `v1.0`
- Image size: Approximately 55.36 MB
- Platform: Linux

**Conclusion:**

Docker Hub provides a centralized registry for storing and distributing Docker images. The published image can now be pulled and deployed on other Docker-enabled machines.


### Task 6: Persist Data with Docker Volumes

**Objective:** Store application data independently of the container lifecycle.

**Implementation:**

1. Created a named Docker volume called `my_volume`.
2. Mounted it at `/app/data` inside the application container.
3. Implemented `/save` and `/read` endpoints to write and read a file.
4. Fixed volume ownership permissions for the Distroless non-root user (UID 65532).
5. Tested data persistence by removing the original container and creating a new container with the same volume.

**Commands used:**

```bash
docker volume create my_volume

docker run --rm --user 0:0 \
  -v my_volume:/app/data \
  alpine sh -c "chown -R 65532:65532 /app/data && chmod 755 /app/data"
```

**Result:**

The application successfully wrote and read data using the named volume. The data remained available after the original container was removed.

**Conclusion:**

Docker volumes provide persistent storage independent of container lifecycle and are useful for databases, application uploads, and other important data.


## Task 7: Configure Docker Networking

### 1. Introduction

Docker Networking allows containers to communicate with each other and external systems.

It is useful in multi-container applications where different services, such as an application server and a database, need to communicate.

### 2. Create a Custom Docker Network

Created a custom bridge network named `my_network`.

```bash
docker network create my_network
```

Verified the network:

```bash
docker network ls
```

### 3. Run MySQL Container on the Network

Attempted to create a MySQL database container:

```bash
docker run -d \
  --name my-db \
  --network my_network \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=sampledb \
  mysql:8.4
```

The MySQL image was successfully downloaded, but the container failed during initialization because of a server startup issue in the limited EC2 environment.

### 4. Run Node.js Application on the Same Network

Created the application container using the custom network:

```bash
docker run -d \
  --name sample-app-network \
  --network my_network \
  -p 8083:80 \
  nirajdhore/sample-app:v1.2
```

Verified the application:

```bash
curl http://localhost:8083/
```

**Output:**

```text
Hello, Docker! Application is running.
```

The application successfully ran inside the custom Docker network.

### 5. Container-to-Container Communication

Docker custom bridge networks provide automatic DNS resolution between connected containers.

For example, an application container can connect to a database container using its container name instead of an IP address.

Example database hostname:

```text
my-db
```

Example MySQL connection configuration:

```text
Host: my-db
Port: 3306
Database: sampledb
Username: root
Password: root
```

A temporary Node.js container can be used to test Docker DNS resolution:

```bash
docker run --rm \
  --network my_network \
  node:22-alpine \
  node -e "require('dns').lookup('my-db',(e,a)=>console.log(e||a))"
```

### 6. Networking Troubleshooting

During implementation, the following issues were encountered:

**Issue 1: Container not running**

The application container initially exited because of a directory permission error.

**Solution:** Updated the Dockerfile to create `/app/data` in the builder stage with ownership assigned to UID 65532.

**Issue 2: DNS resolution failure**

The DNS lookup returned `EAI_AGAIN` because the MySQL container was not running.

**Issue 3: MySQL startup failure**

The MySQL container encountered a server startup error during initialization. The EC2 instance had approximately 908 MB RAM and limited available resources.

The complete MySQL-to-application connection test could therefore not be verified in this environment.

### 7. Importance of Docker Networking

1. Enables communication between multiple containers.
2. Provides automatic DNS resolution on custom networks.
3. Supports microservices architecture.
4. Allows application and database containers to communicate independently.
5. Provides network isolation between different application environments.

### Conclusion

A custom Docker bridge network was created successfully, and the Node.js application was deployed on it. The application was accessible through port 8083.

The exercise demonstrated how Docker networks provide isolated communication between containers and how container names can be used for service discovery. Full database connectivity remained unverified because of MySQL startup limitations on the EC2 instance.



### Task 8: Orchestrate with Docker Compose

**Objective:** Manage a multi-container application using Docker Compose.

**Implementation:**

Created a `docker-compose.yml` file defining two services:

1. **App:** Node.js application using the custom Distroless image.
2. **Database:** MySQL 8.4 database service.

**Additional configurations:**
- Custom bridge network named `app-network`.
- Named volume `db_data` for persistent MySQL storage.
- Health check for the MySQL service.
- `depends_on` with a health condition.
- Resource limits for the MySQL service.

**Deployment commands:**

```bash
docker compose config -q
docker compose up -d
docker compose ps
docker compose logs
docker compose down
```

**Application verification:**

```bash
curl http://localhost:8084/
```

**Output:**

```text
Hello, Docker! Application is running.
```

**Conclusion:**

Docker Compose simplifies multi-container application management by defining services, networks, and volumes in a single YAML configuration file.

**Deployment Verification:**

The Docker Compose deployment was successful.

| Service | Status |
|---|---|
| compose-app | Running |
| compose-db | Healthy |

The application was accessible on port 8084, and the MySQL health check passed.

**Database Persistence Test:**

A named volume `db_data` was configured for persistent MySQL storage.

The MySQL service reached a healthy state during Docker Compose deployment. However, successful data persistence across container recreation was not independently verified.

**Result:** Persistent volume configuration was implemented. Full database persistence verification remains pending.


### Task 9: Analyze Docker Image with Docker Scout

**Objective:** Analyze the Docker image for security vulnerabilities using Docker Scout and understand the importance of container image security.

**Step 1: Install Docker Scout**

Installed Docker Scout CLI and verified its version.

```bash
docker scout version
```

**Installed Version:**
```text
v1.30.0
```

**Step 2: Analyze Docker Image**

Selected Docker image:

```text
nirajdhore/sample-app:v1.0
```

Run Docker Scout Quickview:

```bash
docker scout quickview nirajdhore/sample-app:v1.0
```

Run vulnerability analysis:

```bash
docker scout cves nirajdhore/sample-app:v1.0
```

**Step 3: Generate Vulnerability Report**

```bash
docker scout cves nirajdhore/sample-app:v1.0 > scout_report.txt
```

**Step 4: Troubleshooting**

During the vulnerability scan, Docker Scout encountered a disk quota error while copying image layers into its temporary directory.

The EC2 instance had limited temporary storage.

To resolve this issue, a separate temporary directory was created:

```bash
sudo mkdir -p /var/tmp/docker-scout-tmp
sudo chmod 1777 /var/tmp/docker-scout-tmp
```

The scan was retried using the new temporary directory:

```bash
TMPDIR=/var/tmp/docker-scout-tmp docker scout cves nirajdhore/sample-app:v1.0
```

Docker Scout successfully pulled and stored the image for indexing. However, the final vulnerability scan report was not generated successfully.

The temporary indexing directory eventually occupied approximately 787 MB and was removed during EC2 disk cleanup.

**Result:**

- Docker Scout CLI installed successfully.
- Docker image pull completed successfully.
- Image storage for indexing completed successfully.
- Full CVE analysis remains pending because of temporary storage/indexing issues.
- No vulnerability count or severity results are claimed because a complete report was not generated.

**Future Improvements:**

1. Complete the CVE scan after resolving the indexing issue.
2. Identify vulnerabilities by severity: Critical, High, Medium and Low.
3. Identify affected packages and dependencies.
4. Update vulnerable packages and base images where fixes are available.
5. Rebuild and scan the image again to verify improvements.

**Conclusion:**

Docker Scout provides visibility into container image vulnerabilities and helps developers understand the importance of securing application dependencies and base images.



### Task 10: Documentation and Critical Reflection

**Objective:** Document all Docker implementation tasks, commands, challenges, troubleshooting steps and key learnings.

### 1. Project Overview

This Docker challenge involved containerizing a Node.js application, building optimized Docker images, managing persistent storage, configuring container networking and deploying multiple services using Docker Compose.

The following topics were covered:

1. Introduction to Docker and containerization.
2. Creating and running a Node.js application using Docker.
3. Understanding Docker images, containers and other components.
4. Creating multi-stage and Distroless Docker images.
5. Publishing Docker images to Docker Hub.
6. Implementing persistent storage using Docker volumes.
7. Configuring Docker networking.
8. Managing multi-container applications using Docker Compose.
9. Analyzing image security using Docker Scout.
10. Documenting implementation and reflecting on the learning experience.

### 2. Important Docker Commands

**Image Management**

```bash
docker images
docker build -t sample-app .
docker tag sample-app nirajdhore/sample-app:v1.0
docker push nirajdhore/sample-app:v1.0
docker pull nirajdhore/sample-app:v1.0
```

**Container Management**

```bash
docker run -d -p 8080:80 --name sample-app sample-app
docker ps
docker ps -a
docker logs sample-app
docker stop sample-app
docker rm sample-app
```

**Volume Management**

```bash
docker volume create my_volume
docker volume ls
docker volume inspect my_volume
```

**Network Management**

```bash
docker network create my_network
docker network ls
docker network inspect my_network
```

**Docker Compose**

```bash
docker compose config -q
docker compose up -d
docker compose ps
docker compose logs
docker compose down
```

**Docker Scout**

```bash
docker scout version
docker scout quickview nirajdhore/sample-app:v1.0
docker scout cves nirajdhore/sample-app:v1.0
```

### 3. Key Learnings

- Understood the difference between Docker images and containers.
- Learned to write Dockerfiles and build custom application images.
- Implemented multi-stage builds to reduce image size.
- Explored Distroless images to minimize unnecessary runtime components.
- Published Docker images to Docker Hub.
- Implemented persistent storage using named Docker volumes.
- Learned about custom bridge networks and container communication.
- Deployed a multi-container application using Docker Compose.
- Explored Docker Scout for image vulnerability analysis.
- Learned how to troubleshoot disk space, file permission and container startup issues.

### 4. Challenges Faced and Solutions

**Challenge 1: Container File Permission Issues**

The application initially encountered permission errors while writing data to a mounted volume.

**Solution:** Configured the application data directory with the correct ownership for the non-root Distroless container user.

**Challenge 2: MySQL Container Startup**

The MySQL container encountered startup difficulties on the limited-resource EC2 instance.

**Solution:** Used resource limits and a lightweight MySQL configuration during the Docker Compose exercise. The Compose database subsequently reached a healthy state.

**Challenge 3: Docker Storage Management**

Repeated image pulls and container operations consumed disk space.

**Solution:** Used Docker storage inspection commands and removed unnecessary stopped containers and unused images while preserving important volumes.

**Challenge 4: Docker Scout Temporary Storage**

Docker Scout encountered a disk quota error while copying image layers into `/tmp`.

**Solution Attempted:** Configured an alternative temporary directory under `/var/tmp`. Image storage and indexing started, but the complete CVE scan remains pending.

### 5. Benefits of Docker

1. **Portability:** Applications can run consistently across different environments.
2. **Isolation:** Containers isolate application processes and dependencies.
3. **Efficiency:** Containers generally require fewer resources than traditional virtual machines.
4. **Scalability:** Services can be deployed and managed independently.
5. **CI/CD Integration:** Docker simplifies application packaging and deployment automation.
6. **Reproducibility:** Dockerfiles help create consistent application environments.

### 6. Limitations and Challenges

- Container networking and DNS require proper configuration.
- Volume permissions can cause application errors.
- Resource-intensive services may struggle on low-memory instances.
- Disk space management is important on small servers.
- Container images require regular security scanning and updates.

### 7. Future Improvements

- Complete the pending Docker Scout CVE analysis.
- Verify full application-to-database communication.
- Verify MySQL data persistence across container recreation.
- Improve image security by updating vulnerable dependencies.
- Automate Docker image building and publishing using Jenkins CI/CD.
- Implement container monitoring using Prometheus and Grafana.
- Improve resource management and storage optimization.

### 8. Final Conclusion

This Docker challenge provided practical experience in containerizing a Node.js application, creating optimized Docker images, managing persistent storage, configuring networking, publishing images and deploying multi-container applications.

It also provided exposure to real-world DevOps challenges involving permissions, limited server resources, storage management and container security.

The project established a practical foundation for learning advanced DevOps tools and implementing automated CI/CD pipelines.
