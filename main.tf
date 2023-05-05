terraform {
  required_version = ">= 1.2"

  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = ">= 3.8.2"
    }
  }
}

# Create the Datacenter Group data source
data "vcd_vdc_group" "dcgroup" {
  name    = var.vdc_group_name
}

# Create the NSX-T Edge Gateway data source
data "vcd_nsxt_edgegateway" "t1" {
  org      = var.vdc_org_name
  owner_id = data.vcd_vdc_group.dcgroup.id
  name     = var.vdc_edge_name
}


# Create the vcd_nsxt_nat_rule resource block using for_each to loop through the nat_rules list
resource "vcd_nsxt_nat_rule" "nat_rules" {
  for_each                  = var.nat_rules
  org                       = var.vdc_org_name
  edge_gateway_id           = data.vcd_nsxt_edgegateway.t1.id
  name                      = each.value.name
  rule_type                 = each.value.rule_type
  description               = each.value.description
  external_address          = each.value.external_address
  internal_address          = each.value.internal_address
  snat_destination_address  = each.value.snat_destination_address
  dnat_external_port        = each.value.dnat_external_port
  app_port_profile_id       = each.value.app_port_profile_id
  logging                   = each.value.logging
  firewall_match            = each.value.firewall_match
  priority                  = each.value.priority
}