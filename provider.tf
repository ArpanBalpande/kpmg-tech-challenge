terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.45.0"
    }
  }
}

provider "aws" {
  region                  = "us-east-2"
  shared_credentials_file = "../credentials"
  profile                 = "default"
}