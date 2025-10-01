# AWS + Terraform Portfolio

Hands-on, exam-aligned projects for **AWS Solutions Architect Associate (SAA-C03)** and **Terraform Associate (003)**.  
Each folder contains Terraform code, documentation, and examples that replicate real exam scenarios and AWS best practices.  

> This repository is designed to be pushed straight into your GitHub portfolio.

---

## 📂 Projects by Day

### ✅ Day 1 – IAM
- Create an IAM user and group
- Attach managed policies
- Configure MFA and least privilege
- Terraform: IAM user + policy attachment

📂 `day1-iam/`

---

### ✅ Day 2 – S3 Static Website
- Create S3 bucket for static website hosting
- Configure bucket policy for public access
- Upload `index.html`
- Terraform: S3 + bucket policy

📂 `day2-s3-static-website/`

---

### ✅ Day 3 – S3 Advanced Website Hosting
- Enable static website hosting with custom error page
- Configure versioning and logging
- Apply lifecycle rules for cost optimization
- Terraform: website hosting with `index.html` + `error.html`

📂 `day3-s3-website/`

---

### ✅ Day 4 – EC2 with Apache Web Server
- Launch EC2 (t2.micro Free Tier)
- Configure Security Group (22, 80)
- Install Apache HTTPD and test website
- Terraform: EC2 + SG provisioning

📂 `day4-ec2-apache/`

---

## 🚀 Upcoming Projects (Days 5+)

These will expand into more AWS services aligned with the **SAA-C03 domains**:contentReference[oaicite:1]{index=1}:

- **Day 5:** VPC with public/private subnets + NAT Gateway  
- **Day 6:** RDS with Multi-AZ deployment  
- **Day 7:** Load Balancer + Auto Scaling Group  
- **Day 8:** CloudFront + Route 53 for global distribution  
- **Day 9:** IAM Roles + SSM Parameter Store + Secrets Manager  
- **Day 10:** Monitoring & Logging (CloudWatch, CloudTrail, SNS alerts)  

---

## 🛠️ Prerequisites

- AWS account with CLI profile configured locally (`~/.aws/credentials`)
- Terraform v1.5+
- AWS CLI v2

```bash
aws --version
terraform -version
```
## ▶️ Usage (Generic)

```bash
cd <project-folder>
terraform init
terraform plan -var='aws_profile=default' -var='aws_region=us-east-1'
terraform apply -auto-approve -var='aws_profile=default' -var='aws_region=us-east-1'
```

> Replace `default` and `us-east-1` as needed. You can also set these in `terraform.tfvars`.

## 🧹 Clean Up

Destroy resources to avoid charges:

```bash
terraform destroy -auto-approve -var='aws_profile=default' -var='aws_region=us-east-1'
```

## 📌 Notes

- **Security:** This repo does not commit any credentials. Never commit secrets, state files, or `.tfvars` with sensitive data.
- **Free Tier:** Use free-tier-friendly regions and instance sizes. S3 website hosting is largely free at low traffic.
- **Exam Alignment:** IAM principles (least privilege, users vs roles, managed policies) and S3 fundamentals (versioning, encryption, lifecycle, website hosting) are commonly tested.

---
Created by **Luiz Assef** | Cloud Engineer & DevOps Enthusiast
