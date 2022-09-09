variable "bucket_name" {
  type        = string
  default = "koverse-terraform-backend"
  description = "The name of the S3 bucket that will be used to store terraform backend config"
}


variable "environment" {
  type        = string
  default = "dev"
  description = "Environment where the S3 bucket will be deployed to"
}
