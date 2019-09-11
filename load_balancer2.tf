resource "oci_load_balancer" "load_balancer_public2" {
  shape          = "100Mbps"
  compartment_id = "${var.compartment_ocid}"

  subnet_ids = [
    "${oci_core_subnet.subnet_pubblica4.id}","${oci_core_subnet.subnet_pubblica5.id}"
  ]

  display_name = "LOAD BALANCER PUBLIC2"
}

resource "oci_load_balancer_backend_set" "lb-bes2" {
  name             = "lb-bes2"
  load_balancer_id = "${oci_load_balancer.load_balancer_public2.id}"
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "8181"
    protocol            = "TCP"
#   response_body_regex = ".*"
#    url_path            = "/"
  }

}

resource "oci_load_balancer_backend_set" "lb-bes3" {
  name             = "lb-bes3"
  load_balancer_id = "${oci_load_balancer.load_balancer_public2.id}"
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "8282"
    protocol            = "TCP"
 #   response_body_regex = ".*"
 #   url_path            = "/"
  }

}

resource "oci_load_balancer_backend_set" "lb-bes4" {
  name             = "lb-bes4"
  load_balancer_id = "${oci_load_balancer.load_balancer_public2.id}"
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "8383"
    protocol            = "TCP"
 #   response_body_regex = ".*"
 #   url_path            = "/"
  }

}


resource "oci_load_balancer_listener" "lb-listener3" {
  load_balancer_id         = "${oci_load_balancer.load_balancer_public2.id}"
  name                     = "TCP8181"
  default_backend_set_name = "${oci_load_balancer_backend_set.lb-bes2.name}"
# hostname_names           = ["${oci_load_balancer_hostname.test_server.name}", "${oci_load_balancer_hostname.test_server2.name}"]
  port                     = 8181
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}

resource "oci_load_balancer_listener" "lb-listener4" {
  load_balancer_id         = "${oci_load_balancer.load_balancer_public2.id}"
  name                     = "http2"
  default_backend_set_name = "${oci_load_balancer_backend_set.lb-bes3.name}"
# hostname_names           = ["${oci_load_balancer_hostname.test_server.name}", "${oci_load_balancer_hostname.test_server2.name}"]
  port                     = 8282
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}

resource "oci_load_balancer_listener" "lb-listener5" {
  load_balancer_id         = "${oci_load_balancer.load_balancer_public2.id}"
  name                     = "http3"
  default_backend_set_name = "${oci_load_balancer_backend_set.lb-bes4.name}"
# hostname_names           = ["${oci_load_balancer_hostname.test_server.name}", "${oci_load_balancer_hostname.test_server2.name}"]
  port                     = 8383
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}


resource "oci_load_balancer_backend" "lb-be3" {
  load_balancer_id = "${oci_load_balancer.load_balancer_public2.id}"
  backendset_name  = "${oci_load_balancer_backend_set.lb-bes2.name}"
  ip_address       = "${oci_core_instance.compute_backend.public_ip}"
  port             = 8181
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "lb-be4" {
  load_balancer_id = "${oci_load_balancer.load_balancer_public2.id}"
  backendset_name  = "${oci_load_balancer_backend_set.lb-bes2.name}"
  ip_address       = "${oci_core_instance.compute_backend2.public_ip}"
  port             = 8181
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "lb-be5" {
  load_balancer_id = "${oci_load_balancer.load_balancer_public2.id}"
  backendset_name  = "${oci_load_balancer_backend_set.lb-bes3.name}"
  ip_address       = "${oci_core_instance.compute_backend.public_ip}"
  port             = 8282
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "lb-be6" {
  load_balancer_id = "${oci_load_balancer.load_balancer_public2.id}"
  backendset_name  = "${oci_load_balancer_backend_set.lb-bes3.name}"
  ip_address       = "${oci_core_instance.compute_backend2.public_ip}"
  port             = 8282
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "lb-be7" {
  load_balancer_id = "${oci_load_balancer.load_balancer_public2.id}"
  backendset_name  = "${oci_load_balancer_backend_set.lb-bes4.name}"
  ip_address       = "${oci_core_instance.compute_backend.public_ip}"
  port             = 8383
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "lb-be8" {
  load_balancer_id = "${oci_load_balancer.load_balancer_public2.id}"
  backendset_name  = "${oci_load_balancer_backend_set.lb-bes4.name}"
  ip_address       = "${oci_core_instance.compute_backend2.public_ip}"
  port             = 8383
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}



output "Load Balancer Back-End" {
value="${oci_load_balancer.load_balancer_public2.ip_addresses[0]}"

}

