# Common
# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Install k9s
brew install k9s
# Install sdkman
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version

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
kubectl apply -f .

kubectl port-forward svc/nginx-nodeport-service 8080:80
# svc       - service
# ns        - namespace
# deploy    - deployment
# cm        - configmap
# pv        - persistent volume
# pvc       - persistent volume claim
# default, kube-node-release, kube-public, kube-system

# Create namespace
kubectl create ns dev
kubectl create namespace dev
# Get namespaces
kubectl get ns
# Get pods in the 'dev' namespace
kubectl get pods -n dev
kubectl get all -n dev

# Create deployment
kubectl create deployment nginx-deploy --image=nginx:alpine
kubectl create statefulset nginx-deploy --image=nginx:alpine

kubectl get configmap -n dev
kubectl create configmap app-config --from-literal=env=production

kubectl get secrets -n dev
kubectl get secret -o yaml mysql-secret

# Get persistent volume
kubectl get pv
# Get persistent volume claim
kubectl get pvc

# Helm
Helm list -n dev
Helm install helm-chart -n dev
Helm template helm-chart -n dev

kubectl port-forward svc/inventory-service 8082:8082 -n dev
kubectl port-forward svc/order-service 8080:8080 -n dev

# Inventory service
k delete -f dev/inventory-service/.
k delete -f stage/inventory-service/.
k delete -f prod/inventory-service/.
# ---
k apply -f dev/inventory-service/.
k apply -f stage/inventory-service/.
k apply -f prod/inventory-service/.

# Order service
k delete -f dev/order-service/.
k delete -f stage/order-service/.
k delete -f prod/order-service/.
# ---
k apply -f dev/order-service/.
k apply -f stage/order-service/.
k apply -f prod/order-service/.

