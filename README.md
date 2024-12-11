# Microservice Deployment with Minikube

This project demonstrates how to build and deploy a simple microservice into a Kubernetes cluster using Minikube.

## Overview

The microservice is a Python application built with **FastAPI**, exposing a single endpoint:
- `/student`: Returns a JSON response: `{"student_status": "hired"}`.

### Design Decisions
- **FastAPI Framework**: Chosen for its lightweight, high-performance capabilities and ease of use.
- **Docker & Kubernetes**: To ensure the microservice is portable, scalable, and deployable in modern cloud environments.
- **Minikube**: Provides a local Kubernetes cluster for testing and development.

The deployment process includes:
1. Building a Docker image for the application.
2. Deploying it to a Kubernetes cluster managed by Minikube.
3. Exposing the service and testing its availability.

---

## Prerequisites

1. **Minikube**: Ensure Minikube is installed and running on your local machine.
   - [Install Minikube](https://minikube.sigs.k8s.io/docs/start/)

2. **Docker**: Install Docker for building and managing container images.
   - [Install Docker](https://docs.docker.com/get-docker/)

3. **kubectl**: Install the Kubernetes command-line tool.
   - [Install kubectl](https://kubernetes.io/docs/tasks/tools/)

4. Ensure Minikube is running:
   ```bash
   minikube start
   ```

---

## Project Structure

```plaintext
.
├── app/                     # FastAPI application source code
│   ├── main.py              # Application entry point
│   └── __init__.py          # Required for Python modules
├── deployment.yaml          # Kubernetes Deployment manifest
├── service.yaml             # Kubernetes Service manifest
├── Dockerfile               # Docker build instructions
├── requirements.txt         # Python dependencies
├── build_and_deploy.sh      # Automation script for build and deployment
└── README.md                # Project documentation
```

---

## Instructions for Local and Cluster Deployment

### 1. Clone the Repository
Clone this repository to your local machine:
```bash
git clone <repository_url>
cd <repository_name>
```

### 2. Make the Script Executable
Grant execution permissions to the deployment script:
```bash
chmod +x build_and_deploy.sh
```

### 3. Run the Deployment Script
Execute the script to build the Docker image, apply Kubernetes manifests, and retrieve the service URL:
```bash
./build_and_deploy.sh
```

The script ensures the following:
- Minikube is running.
- Docker builds the microservice image.
- Kubernetes deployment and service are applied.
- The service URL is retrieved dynamically.

### 4. Test the `/student` Endpoint
The script will output the service URL (e.g., `http://127.0.0.1:12345`). To access the `/student` endpoint, you will need to append `/student` manually to the URL. After appending `/student` to the service URL, open it in your browser or test it with `curl`:
```bash
curl http://127.0.0.1:12345/student
```
Expected Response:
```json
{"student_status": "hired"}
```

---

## Kubernetes Manifests

### `deployment.yaml`
Defines the deployment for the FastAPI microservice.
- Replicas: 3
- Container: Uses the Docker image built by the script.

### `service.yaml`
Exposes the deployment as a service.
- Type: `NodePort`
- Ports: Maps port 80 inside the container to a NodePort.

---

## Script Details

The `build_and_deploy.sh` script automates:
1. Checking if Minikube is running.
2. Building the Docker image for the microservice.
3. Applying the Kubernetes manifests (`deployment.yaml` and `service.yaml`).
4. Waiting for pods to become ready.
5. Retrieving the service URL and testing the `/student` endpoint.

---

## Cleanup Instructions
To delete the deployment and service:
```bash
kubectl delete deployment handshake-deployment
kubectl delete service handshake-deployment
```

---

## Notes

- - The project is designed for local testing and development with Minikube.
- The Docker image for this microservice is hosted in the following Docker Hub repository: [1bosquito1 Docker Hub Repository](https://hub.docker.com/repositories/1bosquito1).
- The script pulls the image directly from this repository to ensure that the latest and consistent version of the application is deployed.

### Why Pulling from Docker Hub is Better:
1. **Centralized Management**: The Docker Hub repository allows you to maintain a single source of truth for the application image.
2. **Ease of Collaboration**: Other developers and team members can access and deploy the same image without needing to rebuild it locally.
3. **Faster Deployment**: Minikube pulls the prebuilt image, reducing the need for local builds during deployment.
4. **Scalability**: Ensures consistent images across different environments, including staging and production.

