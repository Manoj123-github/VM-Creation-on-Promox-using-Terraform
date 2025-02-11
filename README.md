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

**terraform {
required_providers {
    proxmox = {
        source = "telmate/proxmox"
        version = "<version tag>"
        }
    }
}**


**Terraform Code**

terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}
 
provider "proxmox" {
  pm_api_url = "proxmox_url"
  pm_api_token_id = "token_id"
  pm_api_token_secret = "toke_secret"
  pm_tls_insecure = true
}
 
resource "proxmox_vm_qemu" "test_server" {
    target_node = "test-prox-1"
    name = "testservermanoj"
    desc = "server using terraform"
     
 
    clone = "template-debian"
 
    agent = 1
 
    os_type = "cloud-init"
    cores = 2
    sockets = 1
    cpu = "host"
    memory = 2048
    scsihw = "virtio-scsi-single"
 
    network {
        bridge = "vmbr0"
        model = "virtio"
    }
 
     disks {
        scsi {
            scsi1 {
                cloudinit {
                    storage = "hdd"
                }
            }
         
            scsi0 {
                disk {
                    size            = 32
                    cache           = "writeback"
                    storage         = "hdd"
 
                    iothread        = true
                    discard         = true
                }
            }
        }
        
    }
     efidisk {
            efitype = "4m"
            storage = "hdd"
        }
      
 
boot = "order=scsi0"
bios = "ovmf"
     
   
}
