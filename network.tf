resource "oci_core_virtual_network" "vcn_test" {
  cidr_block = "10.1.0.0/16"
  compartment_id = "${var.compartment_ocid}"
  display_name = "VCN DI TEST"
  dns_label = "testing"
}

resource "oci_core_subnet" "subnet_pubblica" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD],"name")}"
  cidr_block = "10.1.20.0/24"
  display_name = "SUBNET PUBBLICA"
  dns_label = "public"
  security_list_ids = ["${oci_core_security_list.security_test.id}"]
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.vcn_test.id}"
  route_table_id = "${oci_core_route_table.rt_test.id}"
  dhcp_options_id = "${oci_core_virtual_network.vcn_test.default_dhcp_options_id}"
}

resource "oci_core_subnet" "subnet_pubblica2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  cidr_block = "10.1.21.0/24"
  display_name = "SUBNET PUBBLICA2"
  dns_label = "public2"
  security_list_ids = ["${oci_core_security_list.security_test.id}"]
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.vcn_test.id}"
  route_table_id = "${oci_core_route_table.rt_test.id}"
  dhcp_options_id = "${oci_core_virtual_network.vcn_test.default_dhcp_options_id}"
}

resource "oci_core_subnet" "subnet_pubblica3" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD],"name")}"
  cidr_block = "10.1.22.0/24"
  display_name = "SUBNET PUBBLICA3"
  dns_label = "public3"
  security_list_ids = ["${oci_core_security_list.security_test.id}"]
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.vcn_test.id}"
  route_table_id = "${oci_core_route_table.rt_test.id}"
  dhcp_options_id = "${oci_core_virtual_network.vcn_test.default_dhcp_options_id}"
}

resource "oci_core_subnet" "subnet_pubblica4" {
 availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD],"name")}"
  cidr_block = "10.1.23.0/24"
  display_name = "SUBNET PUBBLICA4"
  dns_label = "public4"
  security_list_ids = ["${oci_core_security_list.security_be.id}"]
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.vcn_test.id}"
  route_table_id = "${oci_core_route_table.rt_test.id}"
  dhcp_options_id = "${oci_core_virtual_network.vcn_test.default_dhcp_options_id}"
}

resource "oci_core_subnet" "subnet_pubblica5" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  cidr_block = "10.1.24.0/24"
  display_name = "SUBNET PUBBLICA5"
  dns_label = "public5"
  security_list_ids = ["${oci_core_security_list.security_be.id}"]
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.vcn_test.id}"
  route_table_id = "${oci_core_route_table.rt_test.id}"
  dhcp_options_id = "${oci_core_virtual_network.vcn_test.default_dhcp_options_id}"
}

resource "oci_core_subnet" "subnet_pubblica6" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 2],"name")}"
  cidr_block = "10.1.25.0/24"
  display_name = "SUBNET PUBBLICA6"
  dns_label = "public6"
  security_list_ids = ["${oci_core_security_list.security_be.id}"]
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.vcn_test.id}"
  route_table_id = "${oci_core_route_table.rt_test.id}"
  dhcp_options_id = "${oci_core_virtual_network.vcn_test.default_dhcp_options_id}"
}

resource "oci_core_subnet" "subnet_db" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  cidr_block = "10.1.26.0/24"
 display_name = "SUBNET DB"
  dns_label = "db"
  security_list_ids = ["${oci_core_security_list.security_db.id}"]
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.vcn_test.id}"
  route_table_id = "${oci_core_route_table.rt_test.id}"
  dhcp_options_id = "${oci_core_virtual_network.vcn_test.default_dhcp_options_id}"
}

resource "oci_core_subnet" "subnet_payment" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  cidr_block = "10.1.27.0/24"
  display_name = "SUBNET PAYMENT"
  dns_label = "payment"
  security_list_ids = ["${oci_core_security_list.security_be.id}"]
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.vcn_test.id}"
  route_table_id = "${oci_core_route_table.rt_test.id}"
  dhcp_options_id = "${oci_core_virtual_network.vcn_test.default_dhcp_options_id}"
}



#per creare una subnet privata aggiungere
#prohibit_public_ip_on_vnic= true 


resource "oci_core_internet_gateway" "ig_test" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "IG DI TEST"
  vcn_id = "${oci_core_virtual_network.vcn_test.id}"
}

resource "oci_core_route_table" "rt_test" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.vcn_test.id}"
  display_name = "RT DI TEST"
  route_rules {
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    network_entity_id = "${oci_core_internet_gateway.ig_test.id}"
  }
}

resource "oci_core_security_list" "security_test"{
compartment_id = "${var.compartment_ocid}"
vcn_id = "${oci_core_virtual_network.vcn_test.id}"
display_name = "SECURITY LIST TEST"

#REGOLE IN INGRESSO DELLA SECURITY LIST


ingress_security_rules{
protocol = "6" #6 E' PROTOCOLLO TCP
source = "0.0.0.0/0"
stateless = false

#PORTE DA APRIRE

        tcp_options{
        "min" = 80
        "max" = 80
        }

}


ingress_security_rules{
protocol = "6" #6 E' PROTOCOLLO TCP
source = "0.0.0.0/0"
stateless = false

#PORTE DA APRIRE

	tcp_options{
	"min" = 8080
	"max" = 8080
	}

}

ingress_security_rules{
protocol = "6" #6 E' PROTOCOLLO TCP
source = "0.0.0.0/0"
stateless = false

#PORTE DA APRIRE

        tcp_options{
        "min" = 443
        "max" = 443
        }

}


ingress_security_rules{
protocol = 6 #PROTOCOLLO TCP
source = "0.0.0.0/0"
stateless = false

	tcp_options{
	"min" = 22
	"max" = 22
	}

}

egress_security_rules{
	destination = "0.0.0.0/0"
	protocol = "6"
}

}
