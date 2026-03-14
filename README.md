# Terraform-template

A full-stack application template built with **Angular**, **NestJS**, and **Terraform** for **Google Cloud Platform (GCP)**. Use this repository as a starting point for projects that need a consistent full-stack architecture with GCP infrastructure provisioned via Terraform.

## Overview

This template provides:

- **Frontend** – Angular 21 single-page application served by Nginx, deployed to Cloud Run.
- **Backend** – NestJS REST API with TypeORM + PostgreSQL, deployed to Cloud Run.
- **Infrastructure** – Reusable Terraform modules covering Cloud Run, Cloud SQL, Cloud Storage, Pub/Sub, Cloud Tasks, Gotenberg, IAM, and Google OAuth secrets.
- **Local development** – Docker Compose stack (PostgreSQL with pgvector, backend, frontend, Gotenberg).

## Repository Structure

```
.
├── client/                        # Angular 21 frontend
│   ├── src/
│   ├── Dockerfile
│   ├── nginx.conf
│   └── FRONTEND_DEPLOYMENT.md     # Frontend deployment guide
├── server/                        # NestJS backend
│   ├── src/
│   ├── Dockerfile
│   ├── .env.example
│   └── BACKEND_DEPLOYMENT.md      # Backend deployment guide
├── terraform/
│   ├── environments/
│   │   ├── dev/                   # Dev environment (main.tf, variables.tf, etc.)
│   │   └── prod/                  # Prod environment
│   └── modules/
│       ├── api/                   # Cloud Run – backend service
│       ├── auth/                  # Google OAuth secrets
│       ├── cloudTask/             # Cloud Tasks queues
│       ├── database/              # Cloud SQL (PostgreSQL)
│       ├── frontend/              # Cloud Run – frontend service
│       ├── gotenberg/             # Gotenberg PDF service
│       ├── iam/                   # Service accounts & IAM bindings
│       ├── pubsub/                # Pub/Sub topics & subscriptions
│       └── storage/               # Cloud Storage buckets
├── docker-compose.yml             # Local development stack
└── README.md
```

## Prerequisites

- [Node.js](https://nodejs.org/) >= 20 and [pnpm](https://pnpm.io/) (used as the package manager)
- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) configured with appropriate credentials
- A GCP project with billing enabled

## Local Development

### 1. Clone the repository

```bash
git clone https://github.com/Floressek/Terraform-template.git
cd Terraform-template
```

### 2. Configure environment variables

```bash
cp server/.env.example server/.env
# Edit server/.env and fill in your values
```

> **Note:** Docker Compose reads environment variables from the root `.env` file. If you intend to run the full stack via Docker Compose, copy the file to the project root as well: `cp server/.env.example .env`.

### 3. Start the full stack with Docker Compose

```bash
docker compose up --build
```

| Service    | URL                   |
|------------|-----------------------|
| Frontend   | http://localhost:4200 |
| Backend    | http://localhost:3000 |
| Gotenberg  | http://localhost:3001 |
| PostgreSQL | localhost:5432        |

### 4. Running services individually

**Backend:**

```bash
cd server
pnpm install
pnpm run start:dev
```

**Frontend:**

```bash
cd client
pnpm install
pnpm run start
```

## Infrastructure (Terraform)

The Terraform code lives in `terraform/`. Each environment (`dev`, `prod`) is a self-contained root module that composes the shared modules.

### Prerequisites

- GCP project with billing enabled
- A GCS bucket for Terraform remote state (update `backend.tf` in the environment folder)
- Google OAuth credentials (Client ID and Secret)

### Deploy to dev

```bash
cd terraform/environments/dev

# Authenticate
gcloud auth application-default login

# Copy and edit the tfvars file
cp terraform.tfvars.example terraform.tfvars
# Fill in project_id, docker_image, frontend_docker_image, google_client_id, google_client_secret

terraform init
terraform plan
terraform apply
```

### Available Terraform modules

| Module       | Description                                      |
|--------------|--------------------------------------------------|
| `api`        | Cloud Run service for the NestJS backend         |
| `auth`       | Google OAuth credentials stored in Secret Manager|
| `cloudTask`  | Cloud Tasks queues (embeddings, file processing) |
| `database`   | Cloud SQL PostgreSQL instance                    |
| `frontend`   | Cloud Run service for the Angular frontend       |
| `gotenberg`  | Gotenberg PDF generation service on Cloud Run    |
| `iam`        | Service accounts and IAM bindings                |
| `pubsub`     | Pub/Sub topics and subscriptions                 |
| `storage`    | Cloud Storage buckets                            |

### Build and push Docker images

See [server/BACKEND_DEPLOYMENT.md](server/BACKEND_DEPLOYMENT.md) and [client/FRONTEND_DEPLOYMENT.md](client/FRONTEND_DEPLOYMENT.md) for detailed build and push instructions.

## License

This project is licensed under the terms of the [LICENSE](LICENSE) file included in this repository.
