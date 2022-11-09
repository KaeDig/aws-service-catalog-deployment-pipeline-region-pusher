/**
 * ## artifact_store.tf
 *
 * Creates an artifact S3 bucket for the pipeline.
 */

resource "aws_s3_bucket" "artifact_store" {
  bucket        = "${local.common_resource_name}-${data.aws_caller_identity.current.account_id}-${var.deployment_region}"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "artifact_store_acl" {
  bucket = aws_s3_bucket.artifact_store.id
  acl    = "private"
}