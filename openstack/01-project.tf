resource "openstack_identity_project_v3" "ipi-project" {
  name        = upper("TERRAFORM${var.env}")
  description = "Projet Terraform pour infr050"
}

output "tenant_id" {
  value = openstack_identity_project_v3.ipi-project.id
}