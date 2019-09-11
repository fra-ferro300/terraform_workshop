 resource "oci_core_instance" "compute_payment" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "COMPUTE PAYMENT"
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
    subnet_id = "${oci_core_subnet.subnet_payment.id}"
    display_name = "TERZO DISCO"
    assign_public_ip = true
    hostname_label = "prova11"
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
        host = "${oci_core_instance.compute_payment.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}
inline = ["sudo mkdir /home/script","sudo chown opc:opc /home/script"]
}


provisioner "file"{
connection {
        host = "${oci_core_instance.compute_payment.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}

source = "/home/payment.sh"
destination = "/home/script/payment.sh"
}
provisioner "file"{
connection {
        host = "${oci_core_instance.compute_payment.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}

source = "/home/francesco/script/startpayment.sh"
destination = "/home/script/startpayment.sh"
}


provisioner "remote-exec"{
connection {
        host = "${oci_core_instance.compute_payment.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}

inline = ["sudo pkill yum","sudo sh /home/script/payment.sh ${oci_core_instance.compute_db.public_ip}"]

}

provisioner "remote-exec"{
connection {
        host = "${oci_core_instance.compute_payment.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}

inline = ["sudo pkill yum","sudo mkdir /home/opc/webapp","sudo chown opc:opc /home/opc/webapp"]

}

provisioner "file"{
connection {
        host = "${oci_core_instance.compute_payment.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
}
source = "/home/francesco/demojars/demojars/"
destination ="/home/opc/webapp/"

}

#provisioner "remote-exec"{
#connection {
#         host = "${oci_core_instance.compute_payment.public_ip}"
#         user = "opc"
#         private_key = "${var.ssh_private_key}"
# }
# inline = ["sh /home/script/startpayment.sh"]
# }
#depends_on = ["oci_core_instance.compute_db"]


}
