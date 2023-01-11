terraform {
  backend s3 {} # Should be manually created before running this code
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.38.0"
    }
  }
}

locals {
  tags = {
    Terraform = "true"
    Stack     = var.stack_name
    Region    = var.aws_region

  }
}

# For practice, nothing to do with this infrastructure.
module "s3" {
  source                      = "./modules/s3"
  tags                        = local.tags
}
