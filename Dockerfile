# Use the official Node.js image as the base image
FROM node:alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json into the working directory
COPY package*.json ./

# Install the application dependencies
RUN npm install 

# Install nest globally
RUN npm install -g @nestjs/cli

# Install prisma globally
RUN npm install -g prisma

# Copy the application source code into the working directory
COPY . .

# Generate the Prisma Client during the Docker image build
RUN npx prisma generate --schema ./prisma/schema.prisma

# Build the application
RUN npm run build

# Expose the application port (default is 3000 for NestJS)
EXPOSE ${APP_PORT}

# Start the application
CMD ["npm", "run", "start:dev"]