/**
 * ## service_catalog.tf
 *
 * This deploys a service catalog product using variables from
 * ./variables.tf.
 *
 * It is a minimal example with the template_url deploying a blank
 * template. The pipeline will overwrite this file with the scanned
 * template file in ./cloudformation/example-ec2.json
 *
 * Please look at this gist as it is hosted externally from this repo
 * therefore can be changed/removed without this repository noticing.
 *
 */

resource "aws_servicecatalog_product" "template" {
  name        = var.product_name
  owner       = var.product_owner
  type        = "CLOUD_FORMATION_TEMPLATE"
  description = var.product_description

  provisioning_artifact_parameters {
    name         = "1"
    template_url = "https://${data.aws_s3_bucket.template_store.bucket}.s3.${var.deployment_region}.amazonaws.com/template.json"
    type = "CLOUD_FORMATION_TEMPLATE"
  }
}