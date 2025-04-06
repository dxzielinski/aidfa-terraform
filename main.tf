resource "google_project_service" "enabled_services" {
  project  = var.project_id
  for_each = toset(var.gcp_services)
  service  = each.value
}

#############################
# Artifact Registry
#############################

resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = var.container_repo
  format        = "DOCKER"
}

#############################
# Cloud Run Services
#############################

resource "google_cloud_run_service" "backend_service" {
  name     = "backend"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/${google_artifact_registry_repository.repo.repository_id}/backend:latest"
      }
    }
  }
}

resource "google_cloud_run_service" "frontend_service" {
  name     = "frontend"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/${google_artifact_registry_repository.repo.repository_id}/frontend:latest"
      }
    }
  }
}

# Allow specific users to invoke backend
resource "google_cloud_run_service_iam_binding" "backend_invoker" {
  service  = google_cloud_run_service.backend_service.name
  location = google_cloud_run_service.backend_service.location
  role     = "roles/run.invoker"
  members  = var.backend_allowed_users
}

# Allow public (unauthenticated) access to frontend
resource "google_cloud_run_service_iam_member" "frontend_invoker" {
  service  = google_cloud_run_service.frontend_service.name
  location = google_cloud_run_service.frontend_service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}