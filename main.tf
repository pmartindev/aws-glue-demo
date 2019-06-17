data "aws_caller_identity" "current_caller" {}

provider "aws" {
  region = "${var.aws_region}"
}
