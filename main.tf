
module "kind_cluster" {
  source = "./modules/kind-cluster"
}

module "tls_private_key" {
  source = "github.com/den-vasyliev/tf-hashicorp-tls-keys"
}

provider "github" {
  owner = var.GITHUB_OWNER
  token = var.GITHUB_TOKEN
}

resource "github_repository_deploy_key" "flux" {
  title      = var.GITHUB_SSH_KEY_TITLE
  repository = var.FLUX_GITHUB_REPO
  key        = module.tls_private_key.public_key_openssh
  read_only  = false
}

module "flux_bootstrap" {
  source = "./modules/fluxcd-flux-bootstrap"

  depends_on = [module.kind_cluster]

  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key       = module.tls_private_key.private_key_pem
  github_token      = var.GITHUB_TOKEN
  config_path       = "${path.root}/kind-cluster-config"
}

provider "kubernetes" {
  config_path = "${path.root}/kind-cluster-config"
}

resource "kubernetes_secret_v1" "kbot" {
  depends_on = [module.flux_bootstrap]

  metadata {
    name      = "kbot"
    namespace = "demo"
  }
  data = {
    token = var.TELE_TOKEN
  }
}
