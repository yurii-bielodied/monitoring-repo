terraform {
  required_providers {
    flux = {
      source = "fluxcd/flux"
    }
  }
}

provider "flux" {
  kubernetes = {
    config_path = var.config_path
  }
  git = {
    url    = "ssh://git@github.com/${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}.git"
    branch = "main"
    ssh = {
      username    = "git"
      private_key = module.tls_private_key.private_key_pem
    }
  }
}

resource "flux_bootstrap_git" "flux" {
  path              = var.target_path
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key       = module.tls_private_key.private_key_pem
  github_token      = var.GITHUB_TOKEN
  config_path       = module.gke_cluster.kubeconfig
}
