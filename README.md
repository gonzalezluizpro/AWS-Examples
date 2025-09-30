
# AWS + Terraform Portfolio (Days 1–2)

Two beginner-friendly, exam-aligned projects for **AWS Solutions Architect Associate (SAA-C03)** and **Terraform Associate (003)**.

> Designed to be pushed straight to your GitHub portfolio.

## Projects

1) **day1-iam/** — Create an IAM user and attach managed policies using Terraform (optionally create access keys).
2) **day2-s3-static-website/** — Host a static website on S3 with public read via bucket policy (Terraform uploads `index.html`).

---

## Prerequisites

- AWS account with a profile configured locally (e.g., `~/.aws/credentials`).
- Terraform v1.5+
- AWS CLI v2

```bash
aws --version
terraform -version
```

## Usage (Generic)

```bash
cd <project-folder>
terraform init
terraform plan -var='aws_profile=default' -var='aws_region=us-east-1'
terraform apply -auto-approve -var='aws_profile=default' -var='aws_region=us-east-1'
```

> Replace `default` and `us-east-1` as needed. You can also set these in `terraform.tfvars`.

## Clean Up

Destroy resources to avoid charges:

```bash
terraform destroy -auto-approve -var='aws_profile=default' -var='aws_region=us-east-1'
```

---

## Notes

- **Security:** This repo does not commit any credentials. Never commit secrets, state files, or `.tfvars` with sensitive data.
- **Free Tier:** Use free-tier-friendly regions and instance sizes. S3 website hosting is largely free at low traffic.
- **Exam Alignment:** IAM principles (least privilege, users vs roles, managed policies) and S3 fundamentals (versioning, encryption, lifecycle, website hosting) are commonly tested.
