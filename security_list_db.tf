resource "oci_core_security_list" "security_db"{
compartment_id = "${var.compartment_ocid}"
vcn_id = "${oci_core_virtual_network.vcn_test.id}"
display_name = "SECURITY LIST DB"

#REGOLE IN INGRESSO DELLA SECURITY LIST

ingress_security_rules{
protocol = "6" #6 E' PROTOCOLLO TCP
source = "0.0.0.0/0"
stateless = false

#PORTE DA APRIRE

	tcp_options{
	"min" = 3306
	"max" = 3306
	}

}


ingress_security_rules{
protocol = "6" #6 E' PROTOCOLLO TCP
source = "0.0.0.0/0"
stateless = false

#PORTE DA APRIRE

        tcp_options{
        "min" = 22
        "max" = 22
        }

}

egress_security_rules{
protocol = "6" #6 E' PROTOCOLLO TCP
destination = "0.0.0.0/0"
}

ingress_security_rules{
protocol = "6" #6 E' PROTOCOLLO TCP
source = "0.0.0.0/0"
stateless = false

#PORTE DA APRIRE

        tcp_options{
        "min" = 1527
        "max" = 1527
        }

}




}
