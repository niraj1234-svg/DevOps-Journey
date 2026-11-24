# DevOps Task Manager

A lightweight full-stack Task Manager application built with Node.js, Express, SQLite, and Docker. The project demonstrates application development, containerization, persistent storage, and deployment using Docker Compose.

## Features

- Create new tasks
- View all tasks
- Mark tasks as completed or incomplete
- Delete tasks
- Persistent SQLite database storage
- Docker containerization
- Docker Compose deployment

## Tech Stack

| Component | Technology |
|---|---|
| Frontend | HTML, CSS, JavaScript |
| Backend | Node.js, Express.js |
| Database | SQLite |
| Containerization | Docker |
| Orchestration | Docker Compose |

## Project Structure

```text
devops-task-manager/
├── backend/
│   ├── server.js
│   ├── package.json
│   └── package-lock.json
├── frontend/
│   ├── index.html
│   ├── style.css
│   └── script.js
├── data/
├── Dockerfile
├── .dockerignore
├── docker-compose.yml
└── README.md
```

## Architecture

```text
             Browser
                |
                v
         Frontend (HTML/CSS/JS)
                |
                v
         Node.js + Express API
                |
                v
           SQLite Database
                |
                v
        Docker Named Volume
```

The Express backend serves both the frontend files and REST API endpoints.

## API Endpoints

| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/health` | Check API health |
| GET | `/api/tasks` | Retrieve all tasks |
| POST | `/api/tasks` | Create a task |
| PUT | `/api/tasks/:id` | Update a task |
| DELETE | `/api/tasks/:id` | Delete a task |

## Run Locally

### 1. Clone the repository

```bash
git clone <YOUR_REPOSITORY_URL>
cd devops-task-manager
```

### 2. Install backend dependencies

```bash
cd backend
npm install
```

### 3. Start the backend

```bash
mkdir -p ../data
npm start
```

The application will run on port `5000`.

Open:

`http://localhost:5000`

## Run Using Docker

### 1. Build Docker Image

```bash
docker build -t devops-task-manager:v1 .
```

### 2. Create Persistent Volume

```bash
docker volume create task-manager-data
```

### 3. Run Container

```bash
docker run -d \
  --name task-manager \
  -p 5000:5000 \
  -v task-manager-data:/data \
  devops-task-manager:v1
```

### 4. Verify Container

```bash
docker ps
docker logs task-manager
```

## Run Using Docker Compose

Build and start the application:

```bash
docker compose up -d --build
```

Check running services:

```bash
docker compose ps
```

View application logs:

```bash
docker compose logs
```

Stop the application:

```bash
docker compose down
```

The named database volume is retained when using `docker compose down` without the `-v` option.

## Database Persistence

The application uses SQLite to store task information.

The database is stored at:

```text
/data/tasks.db
```

Docker named volume:

```text
task-manager-data
```

The database volume ensures that task data remains available after container restarts or container recreation, provided the volume is retained.

## Testing

The following operations were tested:

- Creating tasks through the POST API
- Retrieving tasks through the GET API
- Updating task completion status through the PUT API
- Deleting tasks through the DELETE API
- Checking API health
- Restarting containers
- Verifying database persistence after container restart
- Running the application through Docker Compose

## DevOps Concepts Practiced

- Docker Images and Containers
- Dockerfile Instructions
- Docker Build Context
- Port Mapping
- Docker Named Volumes
- Container Lifecycle Management
- Docker Logs and Debugging
- Docker Compose
- Database Persistence
- Environment Variables

## Future Improvements

- Multi-stage Docker build
- Nginx reverse proxy
- Application health checks
- Container resource limits
- Non-root container execution
- Automated CI/CD using GitHub Actions

## Author

**Niraj Dhore**

GitHub: https://github.com/niraj1234-svg

---

Built as a hands-on DevOps learning project.
