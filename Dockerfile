# Use the official Node.js image as the base image
FROM node:18-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json into the working directory
COPY package*.json ./

# Copy prisma into the working directory
COPY prisma ./prisma/

# Install the application dependencies
RUN npm install 

# Copy the application source code into the working directory
COPY . .

# Build the application
RUN npm run build

FROM node:18-alpine

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/dist ./dist

# Expose the application port (default is 3000 for NestJS)
EXPOSE ${APP_PORT}

# Start the application
CMD ["npm", "run", "start:dev"]