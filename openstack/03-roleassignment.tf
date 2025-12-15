resource "openstack_identity_role_assignment_v3" "role_assignment-ipi" {
  user_id    = openstack_identity_user_v3.ipi-user.id
  project_id = openstack_identity_project_v3.ipi-project.id
  role_id    = data.openstack_identity_role_v3.member.id
}