# Build Inventory and Order service images.
docker built -t inventory-service:v1 inventory-service .
docker built -t order-service:v1 order-service .

# Docker login
docker login

# Tag image and push to docker hub
docker tag inventory-service:v1 vinayk101/inventory-service:v1
docker push vinayk101/order-service:v1
docker tag order-service:v1 vinayk101/order-service:v1
docker push vinayk101/inventory-service:v1

# Create a network
docker network create internal-network

# Run Inventory and Order services
docker run -dp 8082:8082 --network internal-network inventory-service:v1
docker run -dp 8080:8080 --network internal-network order-service:v1

# General commands
docker container ls
docker volume ls
docker network ls
docker ps
docker ps -a
docker images
docker rm <image-id>

