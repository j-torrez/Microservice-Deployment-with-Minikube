#!/bin/bash

set -e  # Exit on error

# Define variables
APP_NAME="handshake-deployment"
DOCKER_IMAGE="$APP_NAME:latest"  # Replace with your actual Docker Hub repo if needed
KUBE_DEPLOYMENT="deployment.yaml"
KUBE_SERVICE="service.yaml"

# Ensure Minikube is running
if ! minikube status | grep -q "host: Running"; then
    echo "Error: Minikube is not running. Please start Minikube before running this script."
    exit 1
fi
echo "✅ Minikube is running."

# Build the Docker image locally
echo "📦 Building Docker image: $DOCKER_IMAGE"
docker build -t $DOCKER_IMAGE .

# Push the image to Docker Hub (optional, if needed)
# echo "🚀 Pushing Docker image to repository..."
# docker push $DOCKER_IMAGE

# Apply Kubernetes manifests
echo "📄 Applying Kubernetes manifests..."
kubectl apply -f $KUBE_DEPLOYMENT
kubectl apply -f $KUBE_SERVICE

# Wait for pods to be ready
echo "⏳ Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod -l app=$APP_NAME --timeout=60s

# Ensure the service is available
echo "Opening the service in Minikube..."
minikube service handshake-deployment

