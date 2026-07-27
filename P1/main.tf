
module "vcn_module"{
    source = "./vcn_module"
    tenancyocid = var.tenancyocid
    userocid = var.userocid
    fingerprint = var.fingerprint
    privatekeypath = var.privatekeypath
    region = var.region
    vcncidrblock = var.vcncidrblock
    vcnname = var.vcnname
    compartmentid = var.compartmentid
}
