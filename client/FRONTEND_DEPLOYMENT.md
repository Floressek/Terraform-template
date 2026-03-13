# Frontend deployment (Docker image)

## Build + push image
Pick a tag and build from repo root:

```sh
IMAGE="europe-central2-docker.pkg.dev/<project-id>/PROJECT-NAME/web:<tag>"
docker build -f client/Dockerfile -t "$IMAGE" .
docker push "$IMAGE"
```

## Terraform

1. Add a tfvars entry for the frontend image (e.g., `frontend_docker_image`).
2. Run Terraform from the target environment:

```sh
cd terraform/environments/dev
terraform init
terraform apply
```
