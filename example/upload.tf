/**
 * ## upload.tf
 *
 * This file creates a zip file of the
 * cloudformation template.
 *
 * Then uploads the zip file to a bucket.
 */

data "aws_s3_bucket" "template_store" {
   dbucket = "service-catalog-templates-${data.aws_caller_identity.current.account_id}-${var.deployment_region}"
}

data "archive_file" "template" {
  type        = "zip"
  source_file = "${path.module}/cloudformation/example-ec2.json"
  output_path = "${path.module}/cloudformation/example-ec2.zip"
}

resource "aws_s3_object" "template" {
  bucket = aws_s3_bucket.template_store.bucket
  key    = basename(data.archive_file.template.output_path)
  source = data.archive_file.template.output_path

  etag = filemd5(data.archive_file.template.output_path)
}