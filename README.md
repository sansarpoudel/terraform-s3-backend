# terraform-s3-backend
 
 This repo can be used to created the KMS encrypted S3 bucket that can be used to store terraform state. If you are using this, you need to create a backend.tf file on your root module with the content similar to this
 
 ```
 terraform {
  backend "s3" {
    bucket = "<bucket name>"
    key    = "workspaces-dev/terraform.tfstate"
    region = "us-west-2"
    encrypt = "true"
    kms_key_id     = "<id to Kms key>"
  }
}
```
