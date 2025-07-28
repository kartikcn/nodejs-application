# Use specific, stable Node image
FROM node:18-alpine3.18

# Set working directory
WORKDIR /app

# Copy only package files first to leverage Docker cache
COPY package*.json ./

# Install dependencies with optional clean cache
RUN npm install --legacy-peer-deps && npm cache clean --force

# Copy the rest of the app
COPY . .

# Optional: ensure everything has correct permissions
RUN chown -R node:node /app

# Expose the port used by your app
EXPOSE 4000

# Use non-root user for better security (optional but recommended)
USER node

# Start the app
CMD [ "npm", "run", "start" ]
