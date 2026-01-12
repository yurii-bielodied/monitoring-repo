
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

variable "github_repository" {
  type        = string
  description = "GitHub repository in format owner/repo"
}

variable "github_token" {
  type        = string
  description = "GitHub personal access token"
  sensitive   = true
}

variable "private_key" {
  type        = string
  description = "SSH private key for Git authentication"
  sensitive   = true
}

variable "target_path" {
  type        = string
  description = "Path in repository for Flux manifests"
  default     = "flux-repo/cluster"
}

variable "TELE_TOKEN" {
  type        = string
  description = "Kbot Telegram bot token"
  sensitive   = true
}
