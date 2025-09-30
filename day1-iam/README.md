
# Day 1 – IAM with Terraform

Creates an **IAM user** and **attaches AWS managed policies**. Optionally creates an **access key** (disabled by default).

## What you learn
- Users vs Groups vs Roles (we create a user).
- Managed policies and least privilege (we attach read-only S3 as an example).
- Optional programmatic access via access keys (use sparingly).

## Deploy

```bash
terraform init
terraform plan -var='aws_profile=default' -var='aws_region=us-east-1' -var='iam_user_name=dev-user'
terraform apply -auto-approve -var='aws_profile=default' -var='aws_region=us-east-1' -var='iam_user_name=dev-user'
```

## Optional: Create an access key
Enable by passing `-var='create_access_key=true'` at plan/apply time.

⚠️ **Security warning:** Treat access keys like passwords. Rotate and delete when not needed.

## Clean up
```bash
terraform destroy -auto-approve -var='aws_profile=default' -var='aws_region=us-east-1' -var='iam_user_name=dev-user'
```

