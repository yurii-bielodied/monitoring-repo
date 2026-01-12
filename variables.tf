
variable "GITHUB_OWNER" {
  type        = string
  description = "GitHub owner repository to use"
}

variable "GITHUB_TOKEN" {
  type        = string
  description = "GitHub personal access token"
}

variable "FLUX_GITHUB_REPO" {
  type        = string
  default     = "flux-gitops"
  description = "Flux GitOps repository"
}

variable "GITHUB_SSH_KEY_TITLE" {
  type        = string
  description = "Title for GitHub SSH deploy key"
  default     = "flux-gitops-deploy-key"
}

variable "config_path" {
  type        = string
  default     = "~/.kube/config"
  description = "The path to the kubeconfig file"
}

variable "TELE_TOKEN" {
  type        = string
  description = "Kbot Telegram bot token"
  sensitive   = true
}
