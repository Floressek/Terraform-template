# Backend deployment (Cloud Run via Terraform)

## Prereqs
- Logged in to GCP and Docker is authenticated for Artifact Registry.
- Terraform initialized for the target environment.

## Build + push image
Pick a tag and build from repo root:

```sh
IMAGE="europe-central2-docker.pkg.dev/<project-id>/PROJECT-NAME/api:<tag>"
docker build -f server/Dockerfile -t "$IMAGE" .
docker push "$IMAGE"
```

## Apply Terraform (dev)
Update the image in `terraform/environments/dev/terraform.tfvars`:

```hcl
docker_image = "europe-central2-docker.pkg.dev/<project-id>/PROJECT-NAME/api:<tag>"
```

Then run:

```sh
cd terraform/environments/dev
terraform init
terraform apply
```

## Notes
- If you keep `:latest`, you can skip editing tfvars, but immutable tags are safer.
