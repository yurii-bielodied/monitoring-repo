
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

provider "flux" {
  kubernetes = {
    host                   = module.kind_cluster.endpoint
    client_certificate     = module.kind_cluster.crt
    client_key             = module.kind_cluster.client_key
    cluster_ca_certificate = module.kind_cluster.ca
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

module "flux_bootstrap" {
  source = "./modules/fluxcd-flux-bootstrap"

  depends_on = [
    module.kind_cluster,
    github_repository_deploy_key.flux
  ]

  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key       = module.tls_private_key.private_key_pem
  github_token      = var.GITHUB_TOKEN
}

provider "kubernetes" {
  host                   = module.kind_cluster.endpoint
  client_certificate     = module.kind_cluster.crt
  client_key             = module.kind_cluster.client_key
  cluster_ca_certificate = module.kind_cluster.ca
}

resource "time_sleep" "wait_for_flux" {
  depends_on      = [module.flux_bootstrap]
  create_duration = "30s"
}

resource "kubernetes_secret_v1" "kbot" {
  depends_on = [time_sleep.wait_for_flux]

  metadata {
    name      = "kbot"
    namespace = "demo"
  }
  data = {
    token = var.TELE_TOKEN
  }
}
