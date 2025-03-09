variable "credentials" {
  description = "GCP Service Account Credentials"
  type        = string
  sensitive   = true
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region for resources"
  type        = string
  default     = "europe-central2"
}

variable "gcp_services" {
  description = "List of GCP services to enable"
  type        = list(string)
  default     = ["artifactregistry.googleapis.com", "cloudbuild.googleapis.com", "run.googleapis.com"]
}

variable "container_repo" {
  description = "Name of the Artifact Registry repository"
  type        = string
}

variable "backend_allowed_users" {
  description = "List of users allowed to invoke the backend service"
  type        = list(string)
}