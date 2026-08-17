set -e

NAME="kubernetes-demo-api"
USERNAME="1dark"
IMAGE="$USERNAME/$NAME:latest"

echo "Building Docker Image..."
docker build -t $IMAGE .

echo "Pushing image to Docker Hub..."
docker push $IMAGE

echo "Applying Kubernetes Deployment..."
kubectl apply -f k8s/deployment.yaml

echo "Applying Kubernetes Service..."
kubectl apply -f k8s/service.yaml

echo "Getting PODS"
kubectl get pods

echo "Getting services"
kubectl get services