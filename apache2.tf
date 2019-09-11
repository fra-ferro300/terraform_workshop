resource "oci_core_instance" "compute_server" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "COMPUTE WEBSERVER2"
  shape = "VM.Standard2.1"

 source_details {
    source_type = "image"
    source_id   = "${var.InstanceImageOCID[var.region]}"

    # Apply this to set the size of the boot volume that's created for this instance.

    # Otherwise, the default boot volume size of the image is used.
    # This should only be specified when source_type is set to "image".
    #boot_volume_size_in_gbs = "60"
}


  create_vnic_details {
    subnet_id = "${oci_core_subnet.subnet_pubblica3.id}"
    display_name = "SECONDA SCHEDA"
    assign_public_ip = true
    hostname_label = "prove2"
  }

  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data = "${base64encode(file(var.BootStrapFile))}"
  }

  timeouts {
    create = "60m"
  }

provisioner "remote-exec"{
connection{
	host = "${oci_core_instance.compute_server.public_ip}"
	user = "opc"
	private_key = "${var.ssh_private_key}"
}
inline = ["sudo mkdir /home/script","sudo chown opc:opc /home/script"]
}




provisioner "file"{
connection {
	host = "${oci_core_instance.compute_server.public_ip}"
	user = "opc"
	private_key = "${var.ssh_private_key}"
}

source = "/home/tomcat.sh"
destination = "/home/script/tomcat.sh"
}

provisioner "file"{
connection {
        host = "${oci_core_instance.compute_server.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}

source = "/home/francesco/script/startweb.sh"
destination = "/home/script/startweb.sh"
}


provisioner "remote-exec"{
connection {
	host = "${oci_core_instance.compute_server.public_ip}"
	user = "opc"
	private_key = "${var.ssh_private_key}"
}

inline = ["sudo pkill yum","sudo sh /home/script/tomcat.sh ${oci_load_balancer.load_balancer_public2.ip_addresses[0]}"]

}

provisioner "remote-exec"{
connection {
        host = "${oci_core_instance.compute_server.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}

inline = ["sudo pkill yum","sudo mkdir /home/opc/webapp","sudo chown opc:opc /home/opc/webapp"]

}

provisioner "file"{
connection {
        host = "${oci_core_instance.compute_server.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}
source = "/home/francesco/demojars/demojars/demoOMCWebapp-2.0.0.RELEASE.war"
destination ="/home/opc/webapp/demoOMCWebapp-2.0.0.RELEASE.war"

}

#provisioner "remote-exec"{
#connection {
#        host = "${oci_core_instance.compute_server.public_ip}"
#        user = "opc"
#        private_key = "${var.ssh_private_key}"
#}
#inline = ["sudo sh /home/script/startweb.sh"]
#}

#depends_on = ["oci_core_instance.compute_backend","oci_core_instance.compute_backend2"]


	
}

