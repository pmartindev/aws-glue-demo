data "aws_caller_identity" "current_caller" {}

provider "aws" {
  region = "${var.aws_region}"
}

module "aws_s3_storage" {
  source = "modules/aws_s3_storage"
}

module "aws_glue_json_parser" {
  source = "modules/aws_glue_json_parser"
  glue_s3_arn = "${module.aws_s3_storage.glue_s3_arn}"
}

