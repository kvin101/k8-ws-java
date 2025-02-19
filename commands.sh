# Docker Commands
# Build Inventory and Order service images.
docker build -t inventory-service:v1 ./inventory-service
docker build -t order-service:v2 ./order-service

# Docker login
docker login

# Tag image and push to docker hub
docker tag inventory-service:v1 vinayk101/inventory-service:v1
docker push vinayk101/inventory-service:v1

docker tag order-service:v2 vinayk101/order-service:v2
docker push vinayk101/order-service:v2

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

docker logs -f <c>


# Kubernetes commands
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/
minikube version
minikube start --driver=docker
minikube status
kubectl get nodes
 
kubectl run my-pod --image=nginx
kubectl label pod my-pod app=nginx
kubectl get pods
kubectl describe pod my-pod
kubectl get all
kubectl logs pod/my-pod
kubectl apply -f temp.yaml

kubectl port-forward svc/nginx-nodeport-service 8080:80
# svc   - service
# ns    - namespace
# default, kube-node-release, kube-public, kube-system

# Create namespace
kubectl create ns dev
kubectl create namespace dev
# Get namespaces
kubectl get ns
# Get pods in the 'dev' namespace
kubectl get pods -n dev
kubectl get all -n dev

