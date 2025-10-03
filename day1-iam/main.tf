
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
}

# Create IAM user
resource "aws_iam_user" "this" {
  name = var.iam_user_name
  path = "/"
}

# Attach one or more managed policies (example: S3 ReadOnly)
resource "aws_iam_user_policy_attachment" "managed" {
  for_each   = toset(var.attach_policy_arns)
  user       = aws_iam_user.this.name
  policy_arn = each.value
}

# OPTIONAL: Create access key for the IAM user (disabled by default)
resource "aws_iam_access_key" "this" {
  count = var.create_access_key ? 1 : 0
  user  = aws_iam_user.this.name
}

output "iam_user_name" {
  value = aws_iam_user.this.name
}

output "attached_policy_arns" {
  value = var.attach_policy_arns
}

# Only output the access key ID, never the secret in logs
output "access_key_id" {
  value       = try(aws_iam_access_key.this[0].id, null)
  description = "If created, the access key ID for the IAM user"
  sensitive   = true
}

