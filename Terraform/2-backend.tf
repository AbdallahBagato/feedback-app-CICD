terraform {
  backend "s3" {
    bucket = "iti-tf-bucket"
    key    = "statefile/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "eksdb"
    encrypt = true
  }
}