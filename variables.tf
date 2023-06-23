variable "vdc_org_name" {}

variable "vdc_edge_name" {}

variable "vdc_group_name" {}

variable "enabled" {
  type    = bool
  default = true
}

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
}
