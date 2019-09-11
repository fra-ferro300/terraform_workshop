resource "oci_core_instance" "compute_backend2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 2],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "COMPUTE BACKEND2"
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
    subnet_id = "${oci_core_subnet.subnet_pubblica6.id}"
    display_name = "QUARTO DISCO"
    assign_public_ip = true
    hostname_label = "prova5"
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
        host = "${oci_core_instance.compute_backend2.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}
inline = ["sudo mkdir /home/script","sudo chown opc:opc /home/script"]
}

provisioner "file"{
connection {
        host = "${oci_core_instance.compute_backend2.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}

source = "/home/backend.sh"
destination = "/home/script/backend.sh"
}

provisioner "file"{
connection {
        host = "${oci_core_instance.compute_backend2.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}

source = "/home/francesco/script/startcatalog.sh"
destination = "/home/script/startcatalog.sh"
}


provisioner "remote-exec"{
connection {
        host = "${oci_core_instance.compute_backend2.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}

inline = ["sudo pkill yum","sudo sh /home/script/backend.sh ${oci_core_instance.compute_db.public_ip} ${oci_core_instance.compute_payment.public_ip}"]

}

provisioner "remote-exec"{
connection {
        host = "${oci_core_instance.compute_backend2.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}

inline = ["sudo pkill yum","sudo mkdir /home/opc/webapp","sudo chown opc:opc /home/opc/webapp"]

}

provisioner "file"{
connection {
        host = "${oci_core_instance.compute_backend2.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}
source = "/home/francesco/demojars/demojars/"
destination ="/home/opc/webapp/"
}

#provisioner "remote-exec"{
#connection {
#         host = "${oci_core_instance.compute_backend2.public_ip}"
#         user = "opc"
#         private_key = "${var.ssh_private_key}"
# }
# inline = ["sh /home/script/startcatalog.sh"]
# }

#depends_on = ["oci_core_instance.compute_db"]


}
