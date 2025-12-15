resource "openstack_identity_project_v3" "ipi-project" {
  name        = "TERRAFORM${var.env}"
  description = "Projet Terraform pour infr050"
}