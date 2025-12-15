resource "openstack_networking_network_v2" "ipi-demo" {
  name           = "ipi-demo-display"
  admin_state_up = "true"
}