terraform {
  required_providers {
    flux = {
      source = "fluxcd/flux"
    }
  }
}

resource "flux_bootstrap_git" "flux" {
  path = var.target_path

  components_extra = [
    "source-watcher",
  ]
}
