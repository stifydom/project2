variable "bucket_name" {
  type        = string
  description = "Name of s3 bucket"
  default     = "pheaa-commprod2020"
}

variable "region" {
  type        = string
  description = "region where aws resources will be created"
  default     = "us-east-1"
}



