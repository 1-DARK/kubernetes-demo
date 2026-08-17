set -e

IMAGE_NAME="kubernetes-demo-api"
SERVICE_NAME="devops-kubernetes-api-service"
DEPLOYMENT_NAME="kubernetes-demo-api"
USERNAME="1dark"
IMAGE="$USERNAME/$IMAGE_NAME:latest"

echo "Building Docker Image..."
docker build -t $IMAGE .

echo "Pushing image to Docker Hub..."
docker push $IMAGE

echo "Applying Kubernetes Deployment..."
kubectl apply -f k8s/deployment.yaml

echo "Restarting rollout to pick up new image..."
kubectl rollout restart deployment/$DEPLOYMENT_NAME

echo "Applying Kubernetes Service..."
kubectl apply -f k8s/service.yaml

echo "Waiting for rollout to finish..."
kubectl rollout status deployment/$DEPLOYMENT_NAME

echo "Getting PODS"
kubectl get pods

echo "Getting services"
kubectl get services

echo "Fetching the main service"
kubectl get services $SERVICE_NAME