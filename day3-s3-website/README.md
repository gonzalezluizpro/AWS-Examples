# Day 3 – S3 Static Website (Advanced)

This lab uses Terraform to create:
- An S3 bucket with public access (for educational use)
- Static website hosting
- `index.html` and `error.html` uploaded by Terraform
- A public read bucket policy

## How to run

```bash
terraform init
terraform apply -auto-approve
```

### Open in browser:
Use the URL in the `website_url` output.

## Cleanup

```bash
terraform destroy -auto-approve
```

⚠️ Never use public S3 buckets for production.
