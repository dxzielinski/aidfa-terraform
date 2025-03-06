variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region for resources"
  type        = string
  default     = "europe-central2"
}

variable "backend_image" {
  description = "Container image for the FastAPI backend"
  type        = string
}

variable "frontend_image" {
    description = "Container image for the React frontend"
    type        = string
}