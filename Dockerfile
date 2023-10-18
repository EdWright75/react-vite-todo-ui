# Use a base image that includes Node.js
FROM node:18-alpine3.18

# Set the working directory
WORKDIR /app

# Copy the built React app to the container
COPY dist/ /app

# Install a lightweight web server like 'serve'
RUN npm install -g serve

# Expose a port (e.g., 80) for the web server
EXPOSE 80

# Define the command to start the web server
CMD ["serve", "-s", ".", "-l", "80"]