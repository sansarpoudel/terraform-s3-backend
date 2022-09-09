resource "aws_kms_key" "terraform_bucket_key" {
 description             = "This key is used to encrypt bucket objects"
 deletion_window_in_days = 10
 enable_key_rotation     = true
}

resource "aws_kms_alias" "key_alias" {
 name          = "alias/terraform_bucket_key"
 target_key_id = aws_kms_key.terraform_bucket_key.key_id
}

resource "aws_s3_bucket" "terraform_state" {
 bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform_bucket_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
 bucket = aws_s3_bucket.terraform_state.id

 block_public_acls       = true
 block_public_policy     = true
 ignore_public_acls      = true
 restrict_public_buckets = true
}

