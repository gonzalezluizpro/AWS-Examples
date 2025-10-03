# Terraform for S3 static website

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "bucket_prefix" {
  description = "Base name for the bucket (will get a random suffix)"
  type        = string
  default     = "my-s3-website"
}

resource "random_id" "suffix" {
  byte_length = 3
}

locals {
  bucket_name = "${var.bucket_prefix}-${random_id.suffix.hex}"
}

resource "aws_s3_bucket" "site" {
  bucket = local.bucket_name
  tags = {
    Project = "s3-static-website"
  }
}

resource "aws_s3_bucket_public_access_block" "site_pab" {
  bucket                  = aws_s3_bucket.site.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "site_web" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  depends_on = [aws_s3_bucket_public_access_block.site_pab]
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.site.id
  key          = "index.html"
  content_type = "text/html"
  content      = "<h1>Hello from Terraform and S3!</h1>"
}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.site.id
  key          = "error.html"
  content_type = "text/html"
  content      = "<h1>Oops! Not Found</h1>"
}

data "aws_iam_policy_document" "public_read" {
  statement {
    effect  = "Allow"
    actions = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = ["${aws_s3_bucket.site.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "site_policy" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.public_read.json
}

output "website_url" {
  value = "http://${aws_s3_bucket_website_configuration.site_web.website_endpoint}"
}
