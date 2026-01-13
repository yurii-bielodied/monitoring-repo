
terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "~> 1.7.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    kind = {
      source  = "tehcyx/kind"
      version = "0.9" # 0.10.0 has a bug with Terraform destroy
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.13.0"
    }
  }
}
