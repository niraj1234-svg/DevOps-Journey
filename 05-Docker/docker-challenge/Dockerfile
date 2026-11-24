# Step 1: Use Node.js base image
FROM node:22-alpine

# Step 2: Set working directory inside container
WORKDIR /app

# Step 3: Copy package.json
COPY app/package*.json ./

# Step 4: Install application dependencies
RUN npm install --omit=dev

# Step 5: Copy application source code
COPY app/ .

# Step 6: Document the port used by application
EXPOSE 80

# Step 7: Start the application
CMD ["npm", "start"]
