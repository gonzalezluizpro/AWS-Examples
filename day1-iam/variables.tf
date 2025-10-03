
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

variable "iam_user_name" {
  description = "Name of the IAM user to create"
  type        = string
  default     = "dev-user"
}

variable "attach_policy_arns" {
  description = "List of managed policy ARNs to attach to the IAM user"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]
}

variable "create_access_key" {
  description = "Whether to create an access key for the IAM user"
  type        = bool
  default     = false
}
