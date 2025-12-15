resource "openstack_identity_user_v3" "ipi-user" {
  default_project_id = openstack_identity_project_v3.ipi-project.id
  name               = "${var.user_name}${var.env}"
  description        = "Terraform demo user"

  password = "B4teau123!"

  ignore_change_password_upon_first_use = true

  multi_factor_auth_enabled = false

  multi_factor_auth_rule {
    rule = ["password", "totp"]
  }

  multi_factor_auth_rule {
    rule = ["password"]
  }

  extra = {
    email = "terraform-demo@ipi.com"
  }
}