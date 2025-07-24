variable "project_id" {
  type        = string
  description = "The project ID"
}

variable "apis" {
  type        = list(string)
  description = "List of APIs to enable"
}

resource "google_project_service" "this" {
  for_each = toset(var.apis)
  project  = var.project_id
  service  = each.key

  disable_on_destroy = false
}
