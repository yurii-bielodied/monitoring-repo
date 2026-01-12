variable "github_repository" {
  type        = string
  description = "GitHub repository to store Flux manifests"
}

variable "target_path" {
  type        = string
  description = "Path in repository for Flux manifests"
  default     = "flux-repo/cluster"
}

variable "github_token" {
  type        = string
  default     = ""
  description = "The token used to authenticate with the Git repository"
}

variable "private_key" {
  type        = string
  description = "The private key used to authenticate with the Git repository"
}
