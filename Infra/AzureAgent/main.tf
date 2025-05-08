terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.35.0"
    }
  }
}
terraform{
  backend "S3" {
    bucket = "Bucket NAME"
    key = "Your Path"
    region = "Your Region of The Bucket"
    dynamodb= "Name of Table"
    }
}
