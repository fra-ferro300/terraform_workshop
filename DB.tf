resource "oci_core_instance" "compute_db" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "COMPUTE DB"
  shape = "VM.Standard2.2"

 source_details {
    source_type = "image"
    source_id   = "${var.InstanceImageOCID[var.region]}"

    # Apply this to set the size of the boot volume that's created for this instance.

    # Otherwise, the default boot volume size of the image is used.
    # This should only be specified when source_type is set to "image".
    #boot_volume_size_in_gbs = "60"
}


  create_vnic_details {
    subnet_id = "${oci_core_subnet.subnet_db.id}"
    display_name = "SESTO DISCO"
    assign_public_ip = true
    hostname_label = "database"
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
	host = "${oci_core_instance.compute_db.public_ip}"
	user = "opc"
	private_key = "${var.ssh_private_key}"
}
inline = ["sudo mkdir /home/script","sudo chown opc:opc /home/script"]
}


provisioner "file"{
	connection {
	host = "${oci_core_instance.compute_db.public_ip}"
	user = "opc"
	private_key = "${var.ssh_private_key}"
}

source = "/home/database.sh"
destination = "/home/script/database.sh"
}

provisioner "file"{
        connection {
        host = "${oci_core_instance.compute_db.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}

source = "/home/francesco/script/startderby.sh"
destination = "/home/script/startderby.sh"
}


provisioner "remote-exec"{
connection {
        host = "${oci_core_instance.compute_db.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}

inline = ["sudo pkill yum","sudo sh /home/script/database.sh"]

}

provisioner "remote-exec"{
connection {
        host = "${oci_core_instance.compute_db.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}

inline = ["sudo pkill yum","sudo mkdir /home/opc/Derby","sudo chown opc:opc /home/opc/Derby"]

}


provisioner "file"{
connection {
        host = "${oci_core_instance.compute_db.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}
source = "/home/francesco/Derby/"
destination ="/home/opc/Derby/"
}

#provisioner "remote-exec"{
#connection {
#        host = "${oci_core_instance.compute_db.public_ip}"
#        user = "opc"
#        private_key = "${var.ssh_private_key}"
#}

#inline = ["cd /home/opc/Derby/db-derby-10.14.2.0-bin/bin","sh NetworkServerControl start -h 0.0.0.0 -p 1527 &>/dev/null &","sleep 1"]

#}


}
