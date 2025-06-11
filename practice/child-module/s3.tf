resource "aws_s3_bucket" "storage1" {
  bucket = var.bucket

  tags = {
    Name        = "storage"
  }
}