
# Use official lightweight Node.js image
FROM node:22-alpine

# Set working directory inside container
WORKDIR /app

# Copy dependency files first
COPY backend/package*.json ./

# Install production dependencies
RUN npm install --omit=dev

# Copy backend source code
COPY backend/ ./

# Copy frontend files
COPY frontend/ ./frontend/

# Create directory for SQLite database
RUN mkdir -p /data

# Set application paths
ENV DB_PATH=/data/tasks.db
ENV FRONTEND_PATH=/app/frontend

# Application port
EXPOSE 5000

# Start backend server
CMD ["npm", "start"]

