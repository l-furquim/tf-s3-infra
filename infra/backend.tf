terraform {
  backend "s3" {
    region = var.aws_region
    bucket = var.bucket_name
  }
}