## Terraform VMware Cloud Director NSX-T Edge Gateway NAT Rules Module

This Terraform module will create NAT rules for an existing NSX-T Edge Gateway in a VMware Cloud Director (VCD) environment using the `vmware/vcd` provider.

## Requirements

| Name      | Version |
|-----------|---------|
| terraform | >= 1.2  |
| vcd       | >= 3.8.2 |

## Resources

| Name                                                             | Type      |
|------------------------------------------------------------------|-----------|
| [vcd_vdc_group](https://registry.terraform.io/providers/vmware/vcd/3.8.2/docs/data-sources/vdc_group) | data source |
| [vcd_nsxt_edgegateway](https://registry.terraform.io/providers/vmware/vcd/3.8.2/docs/data-sources/nsxt_edgegateway) | data source |
| [vcd_nsxt_nat_rule](https://registry.terraform.io/providers/vmware/vcd/3.8.2/docs/resources/nsxt_nat_rule) | resource   |

## Inputs

| Name                          | Description                                                          | Type   | Default           | Required |
|-------------------------------|----------------------------------------------------------------------|--------|-------------------|----------|
| vdc_group_name | Name of the Data Center Group | string | `"Data Center Group Name Format: <Account_Number>-<Region>-<Account_Name> <datacenter group>"` | yes |
| vdc_org_name | Name of the Data Center Group Organization | string | `"Data Center Group Name Format: <Account_Number>-<Region>-<Account_Name>"` | yes |
| vdc_edge_name | Name of the Data Center Group Edge Gateway | string | `"Edge Gateway Name Format: <Account_Number>-<Region>-<Edge_GW_Identifier>-<edge>"` | yes |
| nat_rules | Map of NAT rules to create | map(object({<br>&nbsp;&nbsp;rule_type = string<br>&nbsp;&nbsp;name = string<br>&nbsp;&nbsp;description = optional(string)<br>&nbsp;&nbsp;external_address = optional(string)<br>&nbsp;&nbsp;internal_address = optional(string)<br>&nbsp;&nbsp;snat_destination_address = optional(string)<br>&nbsp;&nbsp;dnat_external_port = optional(string)<br>&nbsp;&nbsp;app_port_profile_id = optional(string)<br>&nbsp;&nbsp;logging = optional(bool)<br>&nbsp;&nbsp;firewall_match = optional(string)<br>&nbsp;&nbsp;priority = optional(number)<br>})) | `{snat_rule = {rule_type = "SNAT", name = 192.168.0.0/24_SNAT, external_address = "8.8.8.8", internal_address = "192.168.0.0/24", logging = false}, dnat_rule = {rule_type = "SNAT", name = 192.168.0.10_DNAT-HTTP, external_address = "8.8.8.8", internal_address = "192.168.0.10", dnat_external_port = "80", logging = false}}` | no |

## Outputs

| Name         | Description             |
|--------------|-------------------------|
| nat_rules | The NAT rules created |

## Example Usage

This is an example of a `main.tf` file that uses the `"github.com/global-vmware/vcd_nsxt_nat_rule"` Module source to create NAT rules for an NSX-T Edge Gateway in a VMware Cloud Director environment:

```terraform
module "vcd_nsxt_nat_rule" {
  source                    = "github.com/global-vmware/vcd_nsxt_nat_rule.git?ref=v1.1.0"
  
  vdc_org_name              = "<VDC-ORG-NAME>"
  vdc_group_name            = "<VDC-GROUP-NAME>"
  vdc_edge_name             = "<NSXT-EDGE-NAME>"

  nat_rules = {
    192.168.0.0/24_SNAT     = {
      rule_type             = "SNAT"
      name                  = "192.168.0.0/24_SNAT"
      external_address      = "8.8.8.8"
      internal_address      = "192.168.0.0/24"
      logging               = false
    },
    192.168.0.10_DNAT-HTTP  = {
      rule_type             = "DNAT"
      name                  = "192.168.0.10_DNAT-HTTP"
      external_address      = "8.8.8.8"
      internal_address      = "192.168.0.10"
      dnat_external_port    = "80"
      logging               = false
    }
  }
}
```