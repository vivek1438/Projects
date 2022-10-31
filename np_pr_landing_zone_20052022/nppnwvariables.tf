#############################################################################
#Variables for creating Non Prod , Prod compartments under "root" compartment
#############################################################################

variable "chubbfs_root_compartment_ocid" {
  default = "ocid1.tenancy.oc1..aaaaaaaaun54bl4ckgfhbbfrhd4fyksat3qrjad3jiw44ebrk45qwq5rebqa"
  type    = string
}

variable "non_prod_compartment_name" {
  default = "Non-Prod"
  type    = string
}

variable "non_prod_compartment_description" {
  default = "Compartment for Non Prod Components"
  type    = string
}

variable "prod_compartment_name" {
  default = "Prod"
  type    = string
}

variable "prod_compartment_description" {
  default = "Compartment for Prod Components"
  type    = string
}

###############################################################
#Variables for creating DR Compartment under "root" compartment
###############################################################

variable "dr_compartment_name" {
  default = "DR"
  type    = string
}

variable "dr_compartment_description" {
  default = "Compartment for DR Components"
  type    = string
}

######################################################
#Variables for creating "DRG" for non-prod & prod VCNs
######################################################

variable "dc_drg_display_name" {
  default = "chubb-dc-drg"
  type    = string
}


############################################################################
#Variables for creating "remote peering connection" for non-prod & prod VCNs
############################################################################

variable "dc_remote_peering_connection" {
  default = "chubb-dc-rpc"
  type    = string
}

###################################################################################
#Variables for creating "non-prod-vcn" and its components in "non-prod-compartment"
###################################################################################

######################################
#Variables for creating "non-prod-vcn"
######################################

variable "non_prod_vcn_display_name" {
  default = "np-vcn"
  type    = string
}

variable "non_prod_vcn_cidr_block" {
  default = "10.107.64.0/22"
  type    = any
}

variable "ipv6_requirement_for_non_prod_vcn" {
  default = "false"
  type    = bool
}

variable "non_prod_vcn_dns_label" {
  default = "npvcn"
  type    = string
}

##################################################################
#Variables for fetching list of availability domains in the region
##################################################################

variable "chubbfs_tenancy_ocid" {
  default = "ocid1.tenancy.oc1..aaaaaaaaun54bl4ckgfhbbfrhd4fyksat3qrjad3jiw44ebrk45qwq5rebqa"
  type    = any
}

############################################################
#variables for creating a Private Subnet-1 in "non-prod-vcn"
############################################################

variable "non_prod_vcn_pvt_sn_1_name" {
  default = "np-pvt-jde-sn01"
  type    = string
}

variable "non_prod_vcn_pvt_sn_1_cidr_block" {
  default = "10.107.64.0/24"
  type    = any
}

variable "non_prod_vcn_pvt_sn_1_dns_name" {
  default = "npjdesn01"
  type    = string
}

variable "prohibit_pvt_ip_non_prod_vcn_pvt_sn_1" {
  default = "true"
  type    = bool
}

############################################################
#variables for creating a Private Subnet-2 in "non-prod-vcn"
############################################################

variable "non_prod_vcn_pvt_sn_2_name" {
  default = "np-pvt-app-sn02"
  type    = string
}

variable "non_prod_vcn_pvt_sn_2_cidr_block" {
  default = "10.107.65.0/24"
  type    = any
}

variable "non_prod_vcn_pvt_sn_2_dns_name" {
  default = "npappsn02"
  type    = string
}

variable "prohibit_pvt_ip_non_prod_vcn_pvt_sn_2" {
  default = "true"
  type    = bool
}

############################################################
#variables for creating a Private Subnet-3 in "non-prod-vcn"
############################################################

variable "non_prod_vcn_pvt_sn_3_name" {
  default = "np-pvt-db-sn03"
  type    = string
}

variable "non_prod_vcn_pvt_sn_3_cidr_block" {
  default = "10.107.66.0/24"
  type    = any
}

variable "non_prod_vcn_pvt_sn_3_dns_name" {
  default = "npdbsn03"
  type    = string
}

variable "prohibit_pvt_ip_non_prod_vcn_pvt_sn_3" {
  default = "true"
  type    = bool
}

############################################################
#variables for creating a Private Subnet-4 in "non-prod-vcn"
############################################################

variable "non_prod_vcn_pvt_sn_4_name" {
  default = "np-pvt-stg-sn04"
  type    = string
}

variable "non_prod_vcn_pvt_sn_4_cidr_block" {
  default = "10.107.67.0/24"
  type    = any
}

variable "non_prod_vcn_pvt_sn_4_dns_name" {
  default = "npstgsn04"
  type    = string
}

variable "prohibit_pvt_ip_non_prod_vcn_pvt_sn_4" {
  default = "true"
  type    = bool
}

##############################################
#Variables for creating LPG for "non-prod-vcn"
##############################################

variable "non_prod_vcn_lpg_name" {
  default = "np-lpg"
  type    = string
}

#################################################
#Variables for creating NAT GW for "non-prod-vcn"
#################################################

variable "non_prod_vcn_ngw_name" {
  default = "np-ngw"
  type    = string
}

#####################################################
#Variables for creating Service GW for "non-prod-vcn"
#####################################################

variable "non_prod_vcn_sgw_name" {
  default = "np-sgw"
  type    = string
}

###############################################################################
#Variables for creating Route Table and Route Rules for "non-prod-vcn-pvt-sn-1"
###############################################################################

variable "non_prod_vcn_pvt_sn_1_rt_name" {
  default = "np-pvt-jde-sn01-rt"
  type    = string
}

###############################################################################
#Variables for creating Route Table and Route Rules for "non-prod-vcn-pvt-sn-2"
###############################################################################

variable "non_prod_vcn_pvt_sn_2_rt_name" {
  default = "np-pvt-app-sn02-rt"
  type    = string
}

###############################################################################
#Variables for creating Route Table and Route Rules for "non-prod-vcn-pvt-sn-3"
###############################################################################

variable "non_prod_vcn_pvt_sn_3_rt_name" {
  default = "np-pvt-db-sn03-rt"
  type    = string
}

###############################################################################
#Variables for creating Route Table and Route Rules for "non-prod-vcn-pvt-sn-4"
###############################################################################

variable "non_prod_vcn_pvt_sn_4_rt_name" {
  default = "np-pvt-stg-sn04-rt"
  type    = string
}

###########################################################################
#Variables for creating Security List and Rules for "non-prod-vcn-pvt-sn-1"
###########################################################################

variable "non_prod_vcn_pvt_sn_1_sl_name" {
  default = "np-pvt-jde-sn01-sl"
  type    = string
}

###########################################################################
#Variables for creating Security List and Rules for "non-prod-vcn-pvt-sn-2"
###########################################################################

variable "non_prod_vcn_pvt_sn_2_sl_name" {
  default = "np-pvt-app-sn02-sl"
  type    = string
}

###########################################################################
#Variables for creating Security List and Rules for "non-prod-vcn-pvt-sn-3"
###########################################################################

variable "non_prod_vcn_pvt_sn_3_sl_name" {
  default = "np-pvt-db-sn03-sl"
  type    = string
}

###########################################################################
#Variables for creating Security List and Rules for "non-prod-vcn-pvt-sn-4"
###########################################################################

variable "non_prod_vcn_pvt_sn_4_sl_name" {
  default = "np-pvt-stg-sn04-sl"
  type    = string
}

###################################################
#Variables for attaching "dc-drg" to "non-prod-vcn"
###################################################

variable "dc_drg_np_attachment_name" {
  default = "np-drg-attachment"
  type    = string
}

#########################################################################
#Variables for creating "prod-vcn" and its components in "prod-compartment"
#########################################################################

#################################
#Variables for creating "prod-vcn"
#################################

variable "prod_vcn_display_name" {
  default = "pr-vcn"
  type    = string
}

variable "prod_vcn_cidr_block" {
  default = "10.107.72.0/22"
  type    = any
}

variable "ipv6_requirement_for_prod_vcn" {
  default = "false"
  type    = bool
}

variable "prod_vcn_dns_label" {
  default = "prvcn"
  type    = string
}

############################################################
#variables for creating a Private Subnet-1 in "prod-vcn"
############################################################

variable "prod_vcn_pvt_sn_1_name" {
  default = "pr-pvt-jde-sn01"
  type    = string
}

variable "prod_vcn_pvt_sn_1_cidr_block" {
  default = "10.107.72.0/24"
  type    = any
}

variable "prod_vcn_pvt_sn_1_dns_name" {
  default = "prjdesn01"
  type    = string
}

variable "prohibit_pvt_ip_prod_vcn_pvt_sn_1" {
  default = "true"
  type    = bool
}

############################################################
#variables for creating a Private Subnet-2 in "prod-vcn"
############################################################

variable "prod_vcn_pvt_sn_2_name" {
  default = "pr-pvt-app-sn02"
  type    = string
}

variable "prod_vcn_pvt_sn_2_cidr_block" {
  default = "10.107.73.0/24"
  type    = any
}

variable "prod_vcn_pvt_sn_2_dns_name" {
  default = "prappsn02"
  type    = string
}

variable "prohibit_pvt_ip_prod_vcn_pvt_sn_2" {
  default = "true"
  type    = bool
}

############################################################
#variables for creating a Private Subnet-3 in "prod-vcn"
############################################################

variable "prod_vcn_pvt_sn_3_name" {
  default = "pr-pvt-db-sn03"
  type    = string
}

variable "prod_vcn_pvt_sn_3_cidr_block" {
  default = "10.107.74.0/24"
  type    = any
}

variable "prod_vcn_pvt_sn_3_dns_name" {
  default = "prdbsn03"
  type    = string
}

variable "prohibit_pvt_ip_prod_vcn_pvt_sn_3" {
  default = "true"
  type    = bool
}

############################################################
#variables for creating a Private Subnet-4 in "prod-vcn"
############################################################

variable "prod_vcn_pvt_sn_4_name" {
  default = "pr-pvt-inf-sn04"
  type    = string
}

variable "prod_vcn_pvt_sn_4_cidr_block" {
  default = "10.107.75.0/26"
  type    = any
}

variable "prod_vcn_pvt_sn_4_dns_name" {
  default = "prinfsn04"
  type    = string
}

variable "prohibit_pvt_ip_prod_vcn_pvt_sn_4" {
  default = "true"
  type    = bool
}

##############################################
#Variables for creating LPG for "prod-vcn"
##############################################

variable "prod_vcn_lpg_name" {
  default = "pr-lpg"
  type    = string
}

#############################################
#Variables for creating NAT GW for "prod-vcn"
#############################################

variable "prod_vcn_ngw_name" {
  default = "pr-ngw"
  type    = string
}

#################################################
#Variables for creating Service GW for "prod-vcn"
#################################################

variable "prod_vcn_sgw_name" {
  default = "pr-sgw"
  type    = string
}

###############################################################################
#Variables for creating Route Table and Route Rules for "prod-vcn-pvt-sn-1"
###############################################################################

variable "prod_vcn_pvt_sn_1_rt_name" {
  default = "pr-pvt-jde-sn01-rt"
  type    = string
}

###############################################################################
#Variables for creating Route Table and Route Rules for "prod-vcn-pvt-sn-2"
###############################################################################

variable "prod_vcn_pvt_sn_2_rt_name" {
  default = "pr-pvt-app-sn02-rt"
  type    = string
}

###############################################################################
#Variables for creating Route Table and Route Rules for "prod-vcn-pvt-sn-3"
###############################################################################

variable "prod_vcn_pvt_sn_3_rt_name" {
  default = "pr-pvt-db-sn03-rt"
  type    = string
}

###############################################################################
#Variables for creating Route Table and Route Rules for "prod-vcn-pvt-sn-4"
###############################################################################

variable "prod_vcn_pvt_sn_4_rt_name" {
  default = "pr-pvt-inf-sn04-rt"
  type    = string
}

###########################################################################
#Variables for creating Security List and Rules for "prod-vcn-pvt-sn-1"
###########################################################################

variable "prod_vcn_pvt_sn_1_sl_name" {
  default = "pr-pvt-jde-sn01-sl"
  type    = string
}

###########################################################################
#Variables for creating Security List and Rules for "prod-vcn-pvt-sn-2"
###########################################################################

variable "prod_vcn_pvt_sn_2_sl_name" {
  default = "pr-pvt-app-sn02-sl"
  type    = string
}

###########################################################################
#Variables for creating Security List and Rules for "prod-vcn-pvt-sn-3"
###########################################################################

variable "prod_vcn_pvt_sn_3_sl_name" {
  default = "pr-pvt-db-sn03-sl"
  type    = string
}

###########################################################################
#Variables for creating Security List and Rules for "prod-vcn-pvt-sn-4"
###########################################################################

variable "prod_vcn_pvt_sn_4_sl_name" {
  default = "pr-pvt-inf-sn04-sl"
  type    = string
}

###############################################
#Variables for attaching "dc-drg" to "prod-vcn"
###############################################

variable "dc_drg_pr_attachment_name" {
  default = "pr-drg-attachment"
  type    = string
}
