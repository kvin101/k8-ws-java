#!/bin/bash

# Function to stop all running containers
echo "Stopping all running Docker containers..."
docker ps -q | xargs -r docker stop

# Function to remove all containers
echo "Removing all Docker containers..."
docker ps -aq | xargs -r docker rm

# Function to remove all Docker images
echo "Removing all Docker images..."
docker images -q | xargs -r docker rmi -f

# Optionally remove all volumes
echo "Removing all Docker volumes..."
docker volume ls -q | xargs -r docker volume rm

# Optionally remove all unused networks
echo "Removing all unused Docker networks..."
docker network ls --filter "dangling=true" -q | xargs -r docker network rm

echo "Docker cleanup completed!"