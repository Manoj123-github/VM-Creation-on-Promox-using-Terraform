# VM-Creation-on-Promox-using-Terraform
**Step 1:** Generate API token for Terraform
Go to Proxmox Web UI. Select Datacenter and look for the 'API Token' tab.
Structure your variables to make use of this API token and Secret
Token ID is User-defined. You can also create another user instead of root and include that user for token creation.
API Token ID and Secret is a one-time thing, once it is generated it will not be available for the next time. So make sure you have copied it down before closing the Token window.


**Step 2:** Installing Proxmox Provider
Proxmox doesn't have an official Terraform Provider, so we will be using the provider maintained by 'Telmate'.

Link for Provider: https://registry.terraform.io/providers/Telmate/proxmox/latest

The Proxmox provider uses the Proxmox API. This provider exposes two resources: proxmoxvmqemu and proxmox_lxc.

Installation Steps: To install this provider, copy and paste this code into your Terraform configuration (include a version tag).


            terraform {
            required_providers {
                proxmox = {
                    source = "telmate/proxmox"
                    version = "<version tag>"
                    }
                }
            }



