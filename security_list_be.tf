resource "oci_core_security_list" "security_be"{
compartment_id = "${var.compartment_ocid}"
vcn_id = "${oci_core_virtual_network.vcn_test.id}"
display_name = "SECURITY LIST BE"

#REGOLE IN INGRESSO DELLA SECURITY LIST

ingress_security_rules{
protocol = "6" #6 E' PROTOCOLLO TCP
source = "0.0.0.0/0"
stateless = false

#PORTE DA APRIRE

	tcp_options{
	"min" = 8181
	"max" = 8181
	}

}


ingress_security_rules{
protocol = 6 #PROTOCOLLO TCP
source = "0.0.0.0/0"
stateless = false

	tcp_options{
	min = 8282
	max = 8282
	}

}

ingress_security_rules{
protocol = 6 #PROTOCOLLO TCP
source = "0.0.0.0/0"
stateless = false

        tcp_options{
        "min" = 8484
        "max" = 8484
        }

}

ingress_security_rules{
protocol = 6 #PROTOCOLLO TCP
source = "0.0.0.0/0"
stateless = false

        tcp_options{
        "min" = 8383
        "max" = 8383
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
