resource "openstack_networking_network_v2" "network-ipi" {
  name           = "network-ipi${var.env}"
  admin_state_up = "true"
  tenant_id      = openstack_identity_project_v3.ipi-project.id
}

resource "openstack_networking_subnet_v2" "subnet-ipi" {
  name       = "subnet-ipi${var.env}"
  network_id = openstack_networking_network_v2.network-ipi.id
  cidr       = "10.0.0.0/24"
  ip_version = 4
}

resource "openstack_networking_secgroup_v2" "secgroup-ipi" {
  name        = "secgroup-ipi${var.env}"
  description = "a security group"
  tenant_id      = openstack_identity_project_v3.ipi-project.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup-ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup-ipi.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup-http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup-ipi.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup-https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup-ipi.id
}