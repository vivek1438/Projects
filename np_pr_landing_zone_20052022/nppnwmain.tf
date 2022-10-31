###############################################################
#Creating Non Prod , Prod compartments under "root" compartment
###############################################################
resource "oci_identity_compartment" "chubb-non-prod" {
  compartment_id = var.chubbfs_root_compartment_ocid
  name           = var.non_prod_compartment_name
  description    = var.non_prod_compartment_description
  enable_delete  = true
}

resource "oci_identity_compartment" "chubb-prod" {
  compartment_id = var.chubbfs_root_compartment_ocid
  name           = var.prod_compartment_name
  description    = var.prod_compartment_description
  enable_delete  = true
}

#################################################
#Creating DR Compartment under "root" compartment
#################################################
resource "oci_identity_compartment" "chubb-dr" {
  compartment_id = var.chubbfs_root_compartment_ocid
  name           = var.dr_compartment_name
  description    = var.dr_compartment_description
  enable_delete  = true
}

########################################
#Creating "DRG" for non-prod & prod VCNs
########################################
resource "oci_core_drg" "chubb_dc_drg" {
  display_name   = var.dc_drg_display_name
  compartment_id = oci_identity_compartment.chubb-prod.id
}

###############################################
#Fetching types of services for Service Gateway
###############################################

data "oci_core_services" "coreservices" {
}

##############################################################
#Creating "remote peering connection" for non-prod & prod VCNs
##############################################################

resource "oci_core_remote_peering_connection" "chubb_dc_remote_peering_connection" {
  display_name   = var.dc_remote_peering_connection
  compartment_id = var.chubbfs_root_compartment_ocid
  drg_id         = oci_core_drg.chubb_dc_drg.id
}

#####################################################################
#Creating "non-prod-vcn" and its components in "non-prod-compartment"
#####################################################################

########################
#Creating "non-prod-vcn"
########################

resource "oci_core_vcn" "non-prod-vcn" {
  display_name   = var.non_prod_vcn_display_name
  compartment_id = oci_identity_compartment.chubb-non-prod.id
  cidr_block     = var.non_prod_vcn_cidr_block
  is_ipv6enabled = var.ipv6_requirement_for_non_prod_vcn
  dns_label      = var.non_prod_vcn_dns_label
}

####################################################
#Fetching list of availability domains in the region
####################################################

data "oci_identity_availability_domains" "ad" {
  compartment_id = var.chubbfs_tenancy_ocid
}

##############################################
#Creating a Private Subnet-1 in "non-prod-vcn"
##############################################

resource "oci_core_subnet" "non-prod-vcn-pvt-sn-1" {
  vcn_id                     = oci_core_vcn.non-prod-vcn.id
  display_name               = var.non_prod_vcn_pvt_sn_1_name
  compartment_id             = oci_identity_compartment.chubb-non-prod.id
  availability_domain        = lookup(data.oci_identity_availability_domains.ad.availability_domains[0], "name")
  cidr_block                 = var.non_prod_vcn_pvt_sn_1_cidr_block
  dns_label                  = var.non_prod_vcn_pvt_sn_1_dns_name
  prohibit_public_ip_on_vnic = var.prohibit_pvt_ip_non_prod_vcn_pvt_sn_1
  security_list_ids          = [oci_core_security_list.non-prod-vcn-pvt-sn-1-sl.id]
}

##############################################
#Creating a Private Subnet-2 in "non-prod-vcn"
##############################################

resource "oci_core_subnet" "non-prod-vcn-pvt-sn-2" {
  vcn_id                     = oci_core_vcn.non-prod-vcn.id
  display_name               = var.non_prod_vcn_pvt_sn_2_name
  compartment_id             = oci_identity_compartment.chubb-non-prod.id
  availability_domain        = lookup(data.oci_identity_availability_domains.ad.availability_domains[0], "name")
  cidr_block                 = var.non_prod_vcn_pvt_sn_2_cidr_block
  dns_label                  = var.non_prod_vcn_pvt_sn_2_dns_name
  prohibit_public_ip_on_vnic = var.prohibit_pvt_ip_non_prod_vcn_pvt_sn_2
  security_list_ids          = [oci_core_security_list.non-prod-vcn-pvt-sn-2-sl.id]
}

##############################################
#Creating a Private Subnet-3 in "non-prod-vcn"
##############################################

resource "oci_core_subnet" "non-prod-vcn-pvt-sn-3" {
  vcn_id                     = oci_core_vcn.non-prod-vcn.id
  display_name               = var.non_prod_vcn_pvt_sn_3_name
  compartment_id             = oci_identity_compartment.chubb-non-prod.id
  availability_domain        = lookup(data.oci_identity_availability_domains.ad.availability_domains[0], "name")
  cidr_block                 = var.non_prod_vcn_pvt_sn_3_cidr_block
  dns_label                  = var.non_prod_vcn_pvt_sn_3_dns_name
  prohibit_public_ip_on_vnic = var.prohibit_pvt_ip_non_prod_vcn_pvt_sn_3
  security_list_ids          = [oci_core_security_list.non-prod-vcn-pvt-sn-3-sl.id]
}

##############################################
#Creating a Private Subnet-4 in "non-prod-vcn"
##############################################

resource "oci_core_subnet" "non-prod-vcn-pvt-sn-4" {
  vcn_id                     = oci_core_vcn.non-prod-vcn.id
  display_name               = var.non_prod_vcn_pvt_sn_4_name
  compartment_id             = oci_identity_compartment.chubb-non-prod.id
  availability_domain        = lookup(data.oci_identity_availability_domains.ad.availability_domains[0], "name")
  cidr_block                 = var.non_prod_vcn_pvt_sn_4_cidr_block
  dns_label                  = var.non_prod_vcn_pvt_sn_4_dns_name
  prohibit_public_ip_on_vnic = var.prohibit_pvt_ip_non_prod_vcn_pvt_sn_4
  security_list_ids          = [oci_core_security_list.non-prod-vcn-pvt-sn-4-sl.id]
}

################################
#Creating LPG for "non-prod-vcn"
################################

resource "oci_core_local_peering_gateway" "non-prod-vcn-lpg" {
  display_name   = var.non_prod_vcn_lpg_name
  compartment_id = oci_identity_compartment.chubb-non-prod.id
  vcn_id         = oci_core_vcn.non-prod-vcn.id
  peer_id        = oci_core_local_peering_gateway.prod-vcn-lpg.id
}

###################################
#Creating NAT GW for "non-prod-vcn"
###################################

resource "oci_core_nat_gateway" "non-prod-vcn-ngw" {
  display_name   = var.non_prod_vcn_ngw_name
  compartment_id = oci_identity_compartment.chubb-non-prod.id
  vcn_id         = oci_core_vcn.non-prod-vcn.id
}

#######################################
#Creating Service GW for "non-prod-vcn"
#######################################

resource "oci_core_service_gateway" "non-prod-vcn-sgw" {
  display_name   = var.non_prod_vcn_sgw_name
  compartment_id = oci_identity_compartment.chubb-non-prod.id
  vcn_id         = oci_core_vcn.non-prod-vcn.id
    services {
    service_id = data.oci_core_services.coreservices.services.1.id
  }
}

#################################################################
#Creating Route Table and Route Rules for "non-prod-vcn-pvt-sn-1"
#################################################################

resource "oci_core_route_table" "non-prod-vcn-pvt-sn-1-rt" {
  display_name   = var.non_prod_vcn_pvt_sn_1_rt_name
  compartment_id = oci_identity_compartment.chubb-non-prod.id
  vcn_id         = oci_core_vcn.non-prod-vcn.id
  route_rules {
    destination       = "10.107.72.0/22"
    network_entity_id = oci_core_local_peering_gateway.non-prod-vcn-lpg.id
  }
    route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.non-prod-vcn-ngw.id
  }  
    route_rules {
	destination_type  = "SERVICE_CIDR_BLOCK"
    destination       = "all-ams-services-in-oracle-services-network"
    network_entity_id = oci_core_service_gateway.non-prod-vcn-sgw.id
  }
  
}

#################################################################
#Creating Route Table and Route Rules for "non-prod-vcn-pvt-sn-2"
#################################################################

resource "oci_core_route_table" "non-prod-vcn-pvt-sn-2-rt" {
  display_name   = var.non_prod_vcn_pvt_sn_2_rt_name
  compartment_id = oci_identity_compartment.chubb-non-prod.id
  vcn_id         = oci_core_vcn.non-prod-vcn.id
  route_rules {
    destination       = "10.107.72.0/22"
    network_entity_id = oci_core_local_peering_gateway.non-prod-vcn-lpg.id
  }
    route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.non-prod-vcn-ngw.id
  }
    route_rules {
	destination_type  = "SERVICE_CIDR_BLOCK"
    destination       = "all-ams-services-in-oracle-services-network"
    network_entity_id = oci_core_service_gateway.non-prod-vcn-sgw.id
  }
}

#################################################################
#Creating Route Table and Route Rules for "non-prod-vcn-pvt-sn-3"
#################################################################

resource "oci_core_route_table" "non-prod-vcn-pvt-sn-3-rt" {
  display_name   = var.non_prod_vcn_pvt_sn_3_rt_name
  compartment_id = oci_identity_compartment.chubb-non-prod.id
  vcn_id         = oci_core_vcn.non-prod-vcn.id
  route_rules {
    destination       = "10.107.72.0/22"
    network_entity_id = oci_core_local_peering_gateway.non-prod-vcn-lpg.id
  }
    route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.non-prod-vcn-ngw.id
  }
    route_rules {
	destination_type  = "SERVICE_CIDR_BLOCK"
    destination       = "all-ams-services-in-oracle-services-network"
    network_entity_id = oci_core_service_gateway.non-prod-vcn-sgw.id
  }
}

#################################################################
#Creating Route Table and Route Rules for "non-prod-vcn-pvt-sn-4"
#################################################################

resource "oci_core_route_table" "non-prod-vcn-pvt-sn-4-rt" {
  display_name   = var.non_prod_vcn_pvt_sn_4_rt_name
  compartment_id = oci_identity_compartment.chubb-non-prod.id
  vcn_id         = oci_core_vcn.non-prod-vcn.id
  route_rules {
    destination       = "10.107.72.0/22"
    network_entity_id = oci_core_local_peering_gateway.non-prod-vcn-lpg.id
  }
    route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.non-prod-vcn-ngw.id
  }
    route_rules {
	destination_type  = "SERVICE_CIDR_BLOCK"
    destination       = "all-ams-services-in-oracle-services-network"
    network_entity_id = oci_core_service_gateway.non-prod-vcn-sgw.id
  }
}

#############################################################
#Creating Security List and Rules for "non-prod-vcn-pvt-sn-1"
#############################################################

resource "oci_core_security_list" "non-prod-vcn-pvt-sn-1-sl" {
  display_name   = var.non_prod_vcn_pvt_sn_1_sl_name
  compartment_id = oci_identity_compartment.chubb-non-prod.id
  vcn_id         = oci_core_vcn.non-prod-vcn.id
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.72.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.72.0/22"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.64.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.64.0/22"
    protocol         = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "0.0.0.0/0"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "SERVICE_CIDR_BLOCK"
    source      = "all-ams-services-in-oracle-services-network"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "SERVICE_CIDR_BLOCK"
    destination      = "all-ams-services-in-oracle-services-network"
    protocol         = "all"
  }
}

#############################################################
#Creating Security List and Rules for "non-prod-vcn-pvt-sn-2"
#############################################################

resource "oci_core_security_list" "non-prod-vcn-pvt-sn-2-sl" {
  display_name   = var.non_prod_vcn_pvt_sn_2_sl_name
  compartment_id = oci_identity_compartment.chubb-non-prod.id
  vcn_id         = oci_core_vcn.non-prod-vcn.id
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.72.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.72.0/22"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.64.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.64.0/22"
    protocol         = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "0.0.0.0/0"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "SERVICE_CIDR_BLOCK"
    source      = "all-ams-services-in-oracle-services-network"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "SERVICE_CIDR_BLOCK"
    destination      = "all-ams-services-in-oracle-services-network"
    protocol         = "all"
  }
}

#############################################################
#Creating Security List and Rules for "non-prod-vcn-pvt-sn-3"
#############################################################

resource "oci_core_security_list" "non-prod-vcn-pvt-sn-3-sl" {
  display_name   = var.non_prod_vcn_pvt_sn_3_sl_name
  compartment_id = oci_identity_compartment.chubb-non-prod.id
  vcn_id         = oci_core_vcn.non-prod-vcn.id
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.72.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.72.0/22"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.64.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.64.0/22"
    protocol         = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "0.0.0.0/0"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "SERVICE_CIDR_BLOCK"
    source      = "all-ams-services-in-oracle-services-network"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "SERVICE_CIDR_BLOCK"
    destination      = "all-ams-services-in-oracle-services-network"
    protocol         = "all"
  }
}

#############################################################
#Creating Security List and Rules for "non-prod-vcn-pvt-sn-4"
#############################################################

resource "oci_core_security_list" "non-prod-vcn-pvt-sn-4-sl" {
  display_name   = var.non_prod_vcn_pvt_sn_4_sl_name
  compartment_id = oci_identity_compartment.chubb-non-prod.id
  vcn_id         = oci_core_vcn.non-prod-vcn.id
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.72.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.72.0/22"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.64.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.64.0/22"
    protocol         = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "0.0.0.0/0"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "SERVICE_CIDR_BLOCK"
    source      = "all-ams-services-in-oracle-services-network"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "SERVICE_CIDR_BLOCK"
    destination      = "all-ams-services-in-oracle-services-network"
    protocol         = "all"
  }
}

##################################################################
#Associating "non-prod-vcn-pvt-sn-1-rt" to "non-prod-vcn-pvt-sn-1"
##################################################################

resource "oci_core_route_table_attachment" "non-prod-vcn-pvt-sn-1-rt-association" {
  subnet_id      = oci_core_subnet.non-prod-vcn-pvt-sn-1.id
  route_table_id = oci_core_route_table.non-prod-vcn-pvt-sn-1-rt.id
}


##################################################################
#Associating "non-prod-vcn-pvt-sn-2-rt" to "non-prod-vcn-pvt-sn-2"
##################################################################

resource "oci_core_route_table_attachment" "non-prod-vcn-pvt-sn-2-rt-association" {
  subnet_id      = oci_core_subnet.non-prod-vcn-pvt-sn-2.id
  route_table_id = oci_core_route_table.non-prod-vcn-pvt-sn-2-rt.id
}

##################################################################
#Associating "non-prod-vcn-pvt-sn-3-rt" to "non-prod-vcn-pvt-sn-3"
##################################################################

resource "oci_core_route_table_attachment" "non-prod-vcn-pvt-sn-3-rt-association" {
  subnet_id      = oci_core_subnet.non-prod-vcn-pvt-sn-3.id
  route_table_id = oci_core_route_table.non-prod-vcn-pvt-sn-3-rt.id
}

##################################################################
#Associating "non-prod-vcn-pvt-sn-4-rt" to "non-prod-vcn-pvt-sn-4"
##################################################################

resource "oci_core_route_table_attachment" "non-prod-vcn-pvt-sn-4-rt-association" {
  subnet_id      = oci_core_subnet.non-prod-vcn-pvt-sn-4.id
  route_table_id = oci_core_route_table.non-prod-vcn-pvt-sn-4-rt.id
}

######################################
#Attaching "dc-drg" to "non-prod-vcn"
######################################

resource "oci_core_drg_attachment" "dc_np_drg_attachment" {
  display_name = var.dc_drg_np_attachment_name
  drg_id       = oci_core_drg.chubb_dc_drg.id
  network_details {
    id   = oci_core_vcn.non-prod-vcn.id
    type = "VCN"
  }
}

#############################################################
#Creating "prod-vcn" and its components in "prod compartment"
#############################################################

resource "oci_core_vcn" "prod-vcn" {
  display_name   = var.prod_vcn_display_name
  compartment_id = oci_identity_compartment.chubb-prod.id
  cidr_block     = var.prod_vcn_cidr_block
  is_ipv6enabled = var.ipv6_requirement_for_prod_vcn
  dns_label      = var.prod_vcn_dns_label
}

##############################################
#Creating a Private Subnet-1 in "prod-vcn"
##############################################

resource "oci_core_subnet" "prod-vcn-pvt-sn-1" {
  vcn_id                     = oci_core_vcn.prod-vcn.id
  display_name               = var.prod_vcn_pvt_sn_1_name
  compartment_id             = oci_identity_compartment.chubb-prod.id
  cidr_block                 = var.prod_vcn_pvt_sn_1_cidr_block
  dns_label                  = var.prod_vcn_pvt_sn_1_dns_name
  prohibit_public_ip_on_vnic = var.prohibit_pvt_ip_prod_vcn_pvt_sn_1
  security_list_ids          = [oci_core_security_list.prod-vcn-pvt-sn-1-sl.id]
}

##############################################
#Creating a Private Subnet-2 in "prod-vcn"
##############################################

resource "oci_core_subnet" "prod-vcn-pvt-sn-2" {
  vcn_id                     = oci_core_vcn.prod-vcn.id
  display_name               = var.prod_vcn_pvt_sn_2_name
  compartment_id             = oci_identity_compartment.chubb-prod.id
  cidr_block                 = var.prod_vcn_pvt_sn_2_cidr_block
  dns_label                  = var.prod_vcn_pvt_sn_2_dns_name
  prohibit_public_ip_on_vnic = var.prohibit_pvt_ip_prod_vcn_pvt_sn_2
  security_list_ids          = [oci_core_security_list.prod-vcn-pvt-sn-2-sl.id]
}

##############################################
#Creating a Private Subnet-3 in "prod-vcn"
##############################################

resource "oci_core_subnet" "prod-vcn-pvt-sn-3" {
  vcn_id                     = oci_core_vcn.prod-vcn.id
  display_name               = var.prod_vcn_pvt_sn_3_name
  compartment_id             = oci_identity_compartment.chubb-prod.id
  cidr_block                 = var.prod_vcn_pvt_sn_3_cidr_block
  dns_label                  = var.prod_vcn_pvt_sn_3_dns_name
  prohibit_public_ip_on_vnic = var.prohibit_pvt_ip_prod_vcn_pvt_sn_3
  security_list_ids          = [oci_core_security_list.prod-vcn-pvt-sn-3-sl.id]
}

##############################################
#Creating a Private Subnet-4 in "prod-vcn"
##############################################

resource "oci_core_subnet" "prod-vcn-pvt-sn-4" {
  vcn_id                     = oci_core_vcn.prod-vcn.id
  display_name               = var.prod_vcn_pvt_sn_4_name
  compartment_id             = oci_identity_compartment.chubb-prod.id
  cidr_block                 = var.prod_vcn_pvt_sn_4_cidr_block
  dns_label                  = var.prod_vcn_pvt_sn_4_dns_name
  prohibit_public_ip_on_vnic = var.prohibit_pvt_ip_prod_vcn_pvt_sn_4
  security_list_ids          = [oci_core_security_list.prod-vcn-pvt-sn-4-sl.id]
}


################################
#Creating LPG for "prod-vcn"
################################

resource "oci_core_local_peering_gateway" "prod-vcn-lpg" {
  display_name   = var.prod_vcn_lpg_name
  compartment_id = oci_identity_compartment.chubb-prod.id
  vcn_id         = oci_core_vcn.prod-vcn.id
}

###############################
#Creating NAT GW for "prod-vcn"
###############################

resource "oci_core_nat_gateway" "prod-vcn-ngw" {
  display_name   = var.prod_vcn_ngw_name
  compartment_id = oci_identity_compartment.chubb-prod.id
  vcn_id         = oci_core_vcn.prod-vcn.id
}

###################################
#Creating Service GW for "prod-vcn"
###################################

resource "oci_core_service_gateway" "prod-vcn-sgw" {
  display_name   = var.prod_vcn_sgw_name
  compartment_id = oci_identity_compartment.chubb-prod.id
  vcn_id         = oci_core_vcn.prod-vcn.id
    services {
    service_id = data.oci_core_services.coreservices.services.1.id
  }
}

#################################################################
#Creating Route Table and Route Rules for "prod-vcn-pvt-sn-1"
#################################################################

resource "oci_core_route_table" "prod-vcn-pvt-sn-1-rt" {
  display_name   = var.prod_vcn_pvt_sn_1_rt_name
  compartment_id = oci_identity_compartment.chubb-prod.id
  vcn_id         = oci_core_vcn.prod-vcn.id
  route_rules {
    destination       = "10.107.64.0/22"
    network_entity_id = oci_core_local_peering_gateway.prod-vcn-lpg.id
  }
  route_rules {
    destination       = "10.107.80.0/22"
    network_entity_id = oci_core_drg.chubb_dc_drg.id
  }
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.prod-vcn-ngw.id
  }
    route_rules {
	destination_type  = "SERVICE_CIDR_BLOCK"
    destination       = "all-ams-services-in-oracle-services-network"
    network_entity_id = oci_core_service_gateway.prod-vcn-sgw.id
  }
}

#################################################################
#Creating Route Table and Route Rules for "prod-vcn-pvt-sn-2"
#################################################################

resource "oci_core_route_table" "prod-vcn-pvt-sn-2-rt" {
  display_name   = var.prod_vcn_pvt_sn_2_rt_name
  compartment_id = oci_identity_compartment.chubb-prod.id
  vcn_id         = oci_core_vcn.prod-vcn.id
  route_rules {
    destination       = "10.107.64.0/22"
    network_entity_id = oci_core_local_peering_gateway.prod-vcn-lpg.id
  }
  route_rules {
    destination       = "10.107.80.0/22"
    network_entity_id = oci_core_drg.chubb_dc_drg.id
  }
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.prod-vcn-ngw.id
  }
    route_rules {
	destination_type  = "SERVICE_CIDR_BLOCK"
    destination       = "all-ams-services-in-oracle-services-network"
    network_entity_id = oci_core_service_gateway.prod-vcn-sgw.id
  }  
}

#################################################################
#Creating Route Table and Route Rules for "prod-vcn-pvt-sn-3"
#################################################################

resource "oci_core_route_table" "prod-vcn-pvt-sn-3-rt" {
  display_name   = var.prod_vcn_pvt_sn_3_rt_name
  compartment_id = oci_identity_compartment.chubb-prod.id
  vcn_id         = oci_core_vcn.prod-vcn.id
  route_rules {
    destination       = "10.107.64.0/22"
    network_entity_id = oci_core_local_peering_gateway.prod-vcn-lpg.id
  }
  route_rules {
    destination       = "10.107.80.0/22"
    network_entity_id = oci_core_drg.chubb_dc_drg.id
  }
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.prod-vcn-ngw.id
  }
      route_rules {
	destination_type  = "SERVICE_CIDR_BLOCK"
    destination       = "all-ams-services-in-oracle-services-network"
    network_entity_id = oci_core_service_gateway.prod-vcn-sgw.id
  }
}

#################################################################
#Creating Route Table and Route Rules for "prod-vcn-pvt-sn-4"
#################################################################

resource "oci_core_route_table" "prod-vcn-pvt-sn-4-rt" {
  display_name   = var.prod_vcn_pvt_sn_4_rt_name
  compartment_id = oci_identity_compartment.chubb-prod.id
  vcn_id         = oci_core_vcn.prod-vcn.id
  route_rules {
    destination       = "10.107.64.0/22"
    network_entity_id = oci_core_local_peering_gateway.prod-vcn-lpg.id
  }
  route_rules {
    destination       = "10.107.80.0/22"
    network_entity_id = oci_core_drg.chubb_dc_drg.id
  }
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.prod-vcn-ngw.id
  }
      route_rules {
	destination_type  = "SERVICE_CIDR_BLOCK"
    destination       = "all-ams-services-in-oracle-services-network"
    network_entity_id = oci_core_service_gateway.prod-vcn-sgw.id
  }
}

#############################################################
#Creating Security List and Rules for "prod-vcn-pvt-sn-1"
#############################################################

resource "oci_core_security_list" "prod-vcn-pvt-sn-1-sl" {
  display_name   = var.prod_vcn_pvt_sn_1_sl_name
  compartment_id = oci_identity_compartment.chubb-prod.id
  vcn_id         = oci_core_vcn.prod-vcn.id
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.64.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.64.0/22"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.72.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.72.0/22"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.80.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.80.0/22"
    protocol         = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "0.0.0.0/0"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "SERVICE_CIDR_BLOCK"
    source      = "all-ams-services-in-oracle-services-network"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "SERVICE_CIDR_BLOCK"
    destination      = "all-ams-services-in-oracle-services-network"
    protocol         = "all"
  }
}

#############################################################
#Creating Security List and Rules for "prod-vcn-pvt-sn-2"
#############################################################

resource "oci_core_security_list" "prod-vcn-pvt-sn-2-sl" {
  display_name   = var.prod_vcn_pvt_sn_2_sl_name
  compartment_id = oci_identity_compartment.chubb-prod.id
  vcn_id         = oci_core_vcn.prod-vcn.id
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.64.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.64.0/22"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.72.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.72.0/22"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.80.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.80.0/22"
    protocol         = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "0.0.0.0/0"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "SERVICE_CIDR_BLOCK"
    source      = "all-ams-services-in-oracle-services-network"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "SERVICE_CIDR_BLOCK"
    destination      = "all-ams-services-in-oracle-services-network"
    protocol         = "all"
  }
}

#############################################################
#Creating Security List and Rules for "prod-vcn-pvt-sn-3"
#############################################################

resource "oci_core_security_list" "prod-vcn-pvt-sn-3-sl" {
  display_name   = var.prod_vcn_pvt_sn_3_sl_name
  compartment_id = oci_identity_compartment.chubb-prod.id
  vcn_id         = oci_core_vcn.prod-vcn.id
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.64.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.64.0/22"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.72.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.72.0/22"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.80.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.80.0/22"
    protocol         = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "0.0.0.0/0"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "SERVICE_CIDR_BLOCK"
    source      = "all-ams-services-in-oracle-services-network"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "SERVICE_CIDR_BLOCK"
    destination      = "all-ams-services-in-oracle-services-network"
    protocol         = "all"
  }
}

#############################################################
#Creating Security List and Rules for "prod-vcn-pvt-sn-4"
#############################################################

resource "oci_core_security_list" "prod-vcn-pvt-sn-4-sl" {
  display_name   = var.prod_vcn_pvt_sn_4_sl_name
  compartment_id = oci_identity_compartment.chubb-prod.id
  vcn_id         = oci_core_vcn.prod-vcn.id
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.64.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.64.0/22"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.72.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.72.0/22"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    source      = "10.107.80.0/22"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "10.107.80.0/22"
    protocol         = "all"
  }
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "0.0.0.0/0"
    protocol         = "all"
  }
  ingress_security_rules {
    source_type = "SERVICE_CIDR_BLOCK"
    source      = "all-ams-services-in-oracle-services-network"
    protocol    = "all"
  }
  egress_security_rules {
    destination_type = "SERVICE_CIDR_BLOCK"
    destination      = "all-ams-services-in-oracle-services-network"
    protocol         = "all"
  }
}

##########################################################
#Associating "prod-vcn-pvt-sn-1-rt" to "prod-vcn-pvt-sn-1"
##########################################################

resource "oci_core_route_table_attachment" "prod-vcn-pvt-sn-1-rt-association" {
  subnet_id      = oci_core_subnet.prod-vcn-pvt-sn-1.id
  route_table_id = oci_core_route_table.prod-vcn-pvt-sn-1-rt.id
}


##################################################################
#Associating "prod-vcn-pvt-sn-2-rt" to "prod-vcn-pvt-sn-2"
##################################################################

resource "oci_core_route_table_attachment" "prod-vcn-pvt-sn-2-rt-association" {
  subnet_id      = oci_core_subnet.prod-vcn-pvt-sn-2.id
  route_table_id = oci_core_route_table.prod-vcn-pvt-sn-2-rt.id
}

##################################################################
#Associating "prod-vcn-pvt-sn-3-rt" to "prod-vcn-pvt-sn-3"
##################################################################

resource "oci_core_route_table_attachment" "prod-vcn-pvt-sn-3-rt-association" {
  subnet_id      = oci_core_subnet.prod-vcn-pvt-sn-3.id
  route_table_id = oci_core_route_table.prod-vcn-pvt-sn-3-rt.id
}

##################################################################
#Associating "prod-vcn-pvt-sn-4-rt" to "prod-vcn-pvt-sn-4"
##################################################################

resource "oci_core_route_table_attachment" "prod-vcn-pvt-sn-4-rt-association" {
  subnet_id      = oci_core_subnet.prod-vcn-pvt-sn-4.id
  route_table_id = oci_core_route_table.prod-vcn-pvt-sn-4-rt.id
}

#################################
#Attaching "dc-drg" to "prod-vcn"
#################################

resource "oci_core_drg_attachment" "dc_p_drg_attachment" {
  display_name = var.dc_drg_pr_attachment_name
  drg_id       = oci_core_drg.chubb_dc_drg.id
  network_details {
    id   = oci_core_vcn.prod-vcn.id
    type = "VCN"
  }
}
