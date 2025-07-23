terraform {
  required_version = "~> 1.12"   ## The Required Version of Terraform
  required_providers {
    aws = {
      version = "~> 5.0"
      source = "hashicorp/aws"  ## Any Version After this Version 
    }
  }
}