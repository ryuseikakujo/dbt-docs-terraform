provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      Env       = "dev"
      App       = "my-app"
      ManagedBy = "Terraform"
    }
  }
}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"

  default_tags {
    tags = {
      Env       = "dev"
      App       = "my-app"
      ManagedBy = "Terraform"
    }
  }
}
