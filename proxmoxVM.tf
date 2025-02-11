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
