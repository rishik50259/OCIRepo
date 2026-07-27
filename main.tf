resource "oci_core_virtual_network" "myvcn" {
  compartment_id = var.compartmentid
  cidr_block     = var.cidrblock
  display_name   = var.displayname
}

resource "oci_core_nat_gateway" "mynatgateway" {
  compartment_id = var.compartmentid
  vcn_id         = oci_core_virtual_network.myvcn.id
  display_name   = "mynatgateway"
}

resource "oci_core_internet_gateway" "myinternetgateway" {
  compartment_id = var.compartmentid
  vcn_id         = oci_core_virtual_network.myvcn.id
  display_name   = "myinternetgateway"
}

resource "oci_core_route_table" "publicroutetable" {
  compartment_id = var.compartmentid
  vcn_id         = oci_core_virtual_network.myvcn.id
  display_name   = "publicroutetable"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.myinternetgateway.id

  }
}

resource "oci_core_route_table" "privateroutetable" {
  compartment_id = var.compartmentid
  vcn_id         = oci_core_virtual_network.myvcn.id
  display_name   = "privateroutetable"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.mynatgateway.id
  }
}

resource "oci_core_subnet" "privatesubnet" {
  compartment_id             = var.compartmentid
  vcn_id                     = oci_core_virtual_network.myvcn.id
  cidr_block                 = var.privatesubnetcidrblock
  display_name               = var.privatesubnetdisplayname
  availability_domain        = var.availabilitydomain
  route_table_id             = oci_core_route_table.privateroutetable.id
  security_list_ids          = [oci_core_security_list.privatesecuritylist.id]
  prohibit_public_ip_on_vnic = true
}

resource "oci_core_subnet" "publicsubnet" {
  compartment_id      = var.compartmentid
  vcn_id              = oci_core_virtual_network.myvcn.id
  cidr_block          = var.publicsubnetcidrblock
  display_name        = var.publicsubnetdisplayname
  availability_domain = var.availabilitydomain
  route_table_id      = oci_core_route_table.publicroutetable.id
  security_list_ids   = [oci_core_security_list.publicsecuritylist.id]
}

resource "oci_core_security_list" "privatesecuritylist" {
  compartment_id = var.compartmentid
  vcn_id         = oci_core_virtual_network.myvcn.id
  display_name   = "mysecuritylist"

  ingress_security_rules {
    protocol = "22" # TCP
    source   = "192.168.56.0/24"
  }
}
resource "oci_core_security_list" "publicsecuritylist" {
  compartment_id = var.compartmentid
  vcn_id         = oci_core_virtual_network.myvcn.id
  display_name   = "mysecuritylist"

  ingress_security_rules {
    protocol = "22" # TCP
    source   = "192.168.56.0/24"
  }
}

data "oci_core_images" "oracle_linux" {
  compartment_id           = var.compartmentid
  operating_system         = "Oracle Linux"
  operating_system_version = "9"
  shape                    = "VM.Standard.E2.1.Micro"
  state                    = "AVAILABLE"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

resource "oci_core_instance" "myinstance" {
  compartment_id      = var.compartmentid
  availability_domain = var.availabilitydomain
  shape               = var.instanceshape
  display_name        = var.instancedisplayname

  create_vnic_details {
    subnet_id        = oci_core_subnet.privatesubnet.id
    assign_public_ip = false
    display_name     = "myvnic"
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.oracle_linux.images[0].id
  }
}