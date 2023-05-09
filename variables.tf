variable "vdc_org_name" {}

variable "vdc_edge_name" {}

variable "vdc_group_name" {}

variable "nat_rules" {
  type = map(object({
    rule_type                   = string
    name                        = string
    description                 = optional(string)
    external_address            = optional(string)
    internal_address            = optional(string)
    snat_destination_address    = optional(string)
    dnat_external_port          = optional(string)
    app_port_profile_id         = optional(string)
    logging                     = optional(bool)
    firewall_match              = optional(string)
    priority                    = optional(number)
  }))
  default = {
    snat_rule = {
      rule_type                 = "SNAT"
      name                      = "192.168.0.0/24_SNAT"
      external_address          = "8.8.8.8"
      internal_address          = "192.168.0.0/24"
      logging                   = false
    },
    dnat_rule = {
      rule_type                 = "DNAT"
      name                      = "192.168.0.10_DNAT-HTTP"
      external_address          = "8.8.8.8"
      internal_address          = "192.168.0.10"
      dnat_external_port        = "80"
      logging                   = false
    },
    no_dnat_rule = {
      rule_type                 = "NO_DNAT"
      name                      = "192.168.0.0/24_NO_DNAT"
      external_address          = "8.8.8.8"
      logging                   = false
    },
    no_snat_rule = {
      rule_type                 = "NO_SNAT"
      name                      = "192.168.0.0/24_NO_SNAT"
      internal_address          = "192.168.0.0/24"
      logging                   = false
    },
    reflexive_rule = {
      rule_type                 = "REFLEXIVE"
      name                      = "192.168.0.10_REFLEXIVE"
      external_address          = "8.8.8.8"
      internal_address          = "192.168.0.10"
      snat_destination_address  = "192.168.0.1"
      logging                   = false
    }
  }
}
