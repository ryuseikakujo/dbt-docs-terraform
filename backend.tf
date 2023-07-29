terraform {
  required_version = ">= 1.5.2"

  required_providers {
    aws = {
      version = "~> 5.7"
    }
  }

  backend "s3" {
    bucket         = "my-tfstate"
    dynamodb_table = "my-tfstate"
    key            = "terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
  }
}
