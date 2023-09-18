terraform {
  required_version = "~>1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}

