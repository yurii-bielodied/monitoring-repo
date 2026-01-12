
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
      version = "0.10"
    }
  }
}
