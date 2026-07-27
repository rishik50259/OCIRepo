variable "region" {
  description = "The OCI region where resource will be created"
  type        = string
  default     = "ap-mumbai-1"
}

variable "tenancyocid" {}
variable "userocid" {}
variable "fingerprint" {}
variable "privatekeypath" {}
variable "compartmentid" {}
variable "vcnname" {}
variable "vcncidrblock" {}