
resource "aws_s3_bucket" "glue_s3_storage" {
  
}

output "glue_s3_arn" {
  value = "${aws_s3_bucket.glue_s3_storage.arn}"
}