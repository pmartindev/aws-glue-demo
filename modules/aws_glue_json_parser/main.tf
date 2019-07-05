variable "glue_s3_arn" {}

resource "aws_iam_role" "glue_iam_role" {
  name               = "AWSGlueServiceRoleDefault"
  assume_role_policy = "${data.aws_iam_policy_document.glue_sts_iam_policy_doc.json}"
}

resource "aws_iam_role_policy_attachment" "glue_service" {
  role       = "${aws_iam_role.glue_iam_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role_policy" "glue_service_s3_policy" {
  role   = "${aws_iam_role.glue_iam_role.id}"
  policy = "${data.aws_iam_policy_document.glue_s3_iam_policy_doc.json}"
}

resource "aws_iam_role_policy" "glue_s3_iam_policy" {
  role       = "${aws_iam_role.glue_iam_role.id}"
  policy = "${data.aws_iam_policy_document.glue_s3_iam_policy_doc.json}"
}
/*************************
********* IAM Data *********
**************************/
data "aws_iam_policy_document" "glue_sts_iam_policy_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals = {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "glue_s3_iam_policy_doc" {
  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "${var.glue_s3_arn}",
      "${var.glue_s3_arn}/*",
    ]
  }
}
