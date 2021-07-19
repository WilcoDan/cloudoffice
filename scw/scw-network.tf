resource "scaleway_instance_security_group" "nc-securitygroup" {
  name                    = "${var.nc_prefix}-securitygroup-${random_string.nc-random.result}"
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"
  inbound_rule {
    action   = "accept"
    port     = 22
    ip_range = var.mgmt_cidr
  }
  inbound_rule {
    action   = "accept"
    port     = var.web_port
    ip_range = var.mgmt_cidr
  }
  inbound_rule {
    action   = "accept"
    port     = var.oo_port
    ip_range = var.mgmt_cidr
  }
  inbound_rule {
    action   = "accept"
    port     = var.web_port
    ip_range = "${scaleway_instance_ip.nc-ip.address}/32"
  }
  inbound_rule {
    action   = "accept"
    port     = var.oo_port
    ip_range = "${scaleway_instance_ip.nc-ip.address}/32"
  }
}
