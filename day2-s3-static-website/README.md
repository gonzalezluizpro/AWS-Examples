
# Day 2 – S3 Static Website with Terraform

Provisions an S3 bucket configured for **static website hosting** and uploads a sample `index.html`. Public read is allowed **via bucket policy** (not ACL).

## What you learn
- Bucket creation & website hosting
- Public access block configuration
- Bucket policy for `s3:GetObject` on `bucket/*`
- Terraform object uploads

## Deploy

```bash
terraform init
terraform plan -var='aws_profile=default' -var='aws_region=us-east-1' -var='bucket_name=my-unique-static-site-1234'
terraform apply -auto-approve -var='aws_profile=default' -var='aws_region=us-east-1' -var='bucket_name=my-unique-static-site-1234'
```

> Bucket names are **globally unique**. Change `bucket_name` to something unique.

## Test
Open the printed `website_endpoint` output in your browser.

## Clean up
```bash
terraform destroy -auto-approve -var='aws_profile=default' -var='aws_region=us-east-1' -var='bucket_name=my-unique-static-site-1234'
```

