variable "compartmentid" {
  type        = string
  description = "The compartment OCID where the resources will be created."
}
variable "cidrblock" {
  type        = string
  description = "The CIDR block for the virtual network."
}
variable "displayname" {
  type        = string
  description = "The display name for the virtual network."
}
variable "src" {
  type        = string
  description = "sourcer provider"
}
variable "versn" {
  type        = string
  description = "provider version"
}
variable "tenancyocid" {
  type        = string
  description = "The OCID of the tenancy."
}
variable "userocid" {
  type        = string
  description = "The OCID of the user."
}
variable "finger_print" {
  type        = string
  description = "The fingerprint of the API key."
}
variable "rgn" {
  type        = string
  description = "The region where the resources will be created."
}
variable "privatekeypath" {
  type        = string
  description = "The path to the private key file."
}
variable "privatesubnetcidrblock" {
  type        = string
  description = "The CIDR block for the private subnet."
}
variable "privatesubnetdisplayname" {
  type        = string
  description = "The display name for the private subnet."
}
variable "availabilitydomain" {
  type        = string
  description = "The availability domain for the private subnet."
}
variable "publicsubnetcidrblock" {
  type        = string
  description = "The CIDR block for the public subnet."
}
variable "publicsubnetdisplayname" {
  type        = string
  description = "The display name for the public subnet."
}
variable "instanceshape" {
  type        = string
  description = "The shape of the instance."
}

variable "instancedisplayname" {
  type        = string
  description = "The display name for the instance."
}

