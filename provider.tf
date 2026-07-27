terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">=4.0.0"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancyocid
  user_ocid        = var.userocid
  fingerprint      = var.finger_print
  region           = var.rgn
  private_key_path = var.privatekeypath
}