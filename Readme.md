# Kubernetes Demo

A minimal Node.js API packaged in Docker and deployed to Kubernetes — useful for learning containers, probes, and basic K8s workflows.

## What it does

- Serves a JSON greeting from `/` with pod metadata
- Exposes `/healthz` and `/readyz` for liveness and readiness probes
- Runs locally with npm or Docker Compose
- Builds a Docker image, pushes to Docker Hub, and deploys 2 replicas via `deploy.sh`

## Tech stack

- **Runtime:** Node.js 22, Express 5
- **Containers:** Docker, Docker Compose
- **Orchestration:** Kubernetes (minikube), kubectl

## Project structure

```
.
├── index.js              # Express API
├── Dockerfile            # Production image
├── docker-compose.yaml   # Local container setup
├── deploy.sh             # Build, push, and deploy to K8s
├── k8s/
│   ├── deployment.yaml   # 2-replica deployment + probes
│   └── service.yaml      # NodePort service
└── package.json
```

## Prerequisites

- Node.js 22+
- Docker
- kubectl
- minikube (for local Kubernetes)
- Docker Hub account (for `deploy.sh` image push)

## Local development

```bash
npm install
npm run dev          # nodemon on http://localhost:3000
```

Or with Docker Compose:

```bash
docker compose up --build
```

## Deploy to Kubernetes

```bash
minikube start
npm run deploy       # or: sh deploy.sh
minikube service devops-kubernetes-api-service
```

`deploy.sh` builds the image, pushes `1dark/kubernetes-demo-api:latest`, applies the manifests, and waits for rollout.

## API endpoints

| Method | Path     | Description                          |
|--------|----------|--------------------------------------|
| GET    | `/`      | JSON greeting with pod name and time |
| GET    | `/healthz` | Liveness probe (returns `ok`)      |
| GET    | `/readyz`  | Readiness probe (returns `ready`)  |

## Example response

`GET /`

```json
{
  "message": "Hello from a Container!",
  "service": "hello-node",
  "pod": "kubernetes-demo-api-abc123-xyz",
  "time": "2026-08-17T16:00:00.000Z"
}
```