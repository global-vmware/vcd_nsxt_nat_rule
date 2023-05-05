output "nat_rules" {
  value = {
    for k, v in vcd_nsxt_nat_rule.nat_rules : k => {
      name                  = v.name
      rule_type             = v.rule_type
      description           = v.description
      external_address      = v.external_address
      internal_address      = v.internal_address
      snat_destination_address = v.snat_destination_address
      dnat_external_port    = v.dnat_external_port
      app_port_profile_id   = v.app_port_profile_id
      logging               = v.logging
      firewall_match        = v.firewall_match
      priority              = v.priority
    }
  }
}
