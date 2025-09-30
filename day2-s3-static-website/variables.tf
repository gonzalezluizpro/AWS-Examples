
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "default"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name for website hosting"
  type        = string
}
