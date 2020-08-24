provider "vsphere" {
  # If you have a self-signed cert
  allow_unverified_ssl = true
}

variable "vm_name" {
  default = "disksize-test"
}

variable "vm_count" {
  default = 1
}

data "vsphere_datacenter" "dc" {
  name = "CMBU_ES_SCALE_VC01_ATL_DC"
}

data "vsphere_datastore" "datastore" {
  name          = "vsanDatastore"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "CMBU_ES_SCALE_VC01_ATL_CLUSTER_01/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "cmbu_es_scale_vc01_vm_privatevlan3003"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "WebTinyCentOS65x86"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "clone" {
  count            = ${vr.vm_count}
  name             = "${var.vm_name}-${count.index}" 
  resource_pool_id = data.vsphere_resource_pool.pool.id 
  datastore_id     = data.vsphere_datastore.datastore.id  
  num_cpus = 1 
  memory   = 1024 
  guest_id = data.vsphere_virtual_machine.template.guest_id 
  scsi_type = data.vsphere_virtual_machine.template.scsi_type 
  wait_for_guest_net_timeout = -1 
  network_interface { 
    network_id   = data.vsphere_network.network.id 
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0] 
  } 
  disk { 
    label = "disk1" 
    size = 5 
  } 
}
