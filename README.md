# Terraform-template

A template repository providing a baseline Terraform project structure for **Google Cloud Platform (GCP)** projects.

## Overview

Use this repository as a starting point when bootstrapping new GCP infrastructure with Terraform. It is designed to enforce a consistent directory layout and configuration style across projects.

## Repository Structure

```
.
├── environments/        # Per-environment variable files (dev, staging, prod)
├── modules/             # Reusable Terraform modules
│   ├── network/         # VPC, subnets, firewall rules
│   ├── iam/             # Service accounts and IAM bindings
│   └── compute/         # Compute Engine / GKE resources
├── main.tf              # Root module – calls child modules
├── variables.tf         # Input variable declarations
├── outputs.tf           # Output value declarations
├── versions.tf          # Terraform and provider version constraints
└── README.md
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) configured with appropriate credentials
- A GCP project with billing enabled

## Getting Started

1. **Clone / use this template**

   ```bash
   git clone https://github.com/Floressek/Terraform-template.git my-gcp-infra
   cd my-gcp-infra
   ```

2. **Configure your GCP project**

   ```bash
   gcloud auth application-default login
   export GOOGLE_PROJECT="your-gcp-project-id"
   ```

3. **Initialize Terraform**

   ```bash
   terraform init
   ```

4. **Plan and apply**

   ```bash
   terraform plan -var-file="environments/dev.tfvars"
   terraform apply -var-file="environments/dev.tfvars"
   ```

## License

This project is licensed under the terms of the [LICENSE](LICENSE) file included in this repository.
