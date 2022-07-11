terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 3.16"
    }
  }
}


provider "aws" {
  region = "us-west-2"
}