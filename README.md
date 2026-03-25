# Orderly App — GitOps Configuration

GitOps configuration repository for [orderly-app](https://github.com/rahmansabiurfx/orderly-app).

This repository is the **single source of truth** for what's deployed in Kubernetes. ArgoCD watches this repo and automatically syncs any changes to the cluster.

## Structure
```
helm-chart/               # Helm chart for the application
├── Chart.yaml            # Chart metadata
├── values.yaml           # Default values
├── values-dev.yaml       # Dev environment overrides
├── values-staging.yaml   # Staging environment overrides
├── values-prod.yaml      # Production environment overrides
└── templates/            # Kubernetes manifest templates
    ├── deployment.yaml
    ├── service.yaml
    ├── ingress.yaml
    ├── hpa.yaml
    └── configmap.yaml

argocd/                   # ArgoCD application definitions
└── application.yaml
```

## How It Works
1. CI pipeline in `orderly-app` builds and pushes a new Docker image
2. CI pipeline updates `image.tag` in this repo's values file
3. ArgoCD detects the change (polls every 3 minutes)
4. ArgoCD syncs the new desired state to Kubernetes
5. Kubernetes performs a rolling update to the new image version

## Environments
| Environment | Values File | Replicas | Purpose |
|-------------|-------------|----------|---------|
| Dev | values-dev.yaml | 1 | Development testing |
| Staging | values-staging.yaml | 2 | Pre-production validation |
| Prod | values-prod.yaml | 3 | Production |
