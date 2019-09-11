resource "oci_load_balancer" "load_balancer_public" {
  shape          = "100Mbps"
  compartment_id = "${var.compartment_ocid}"

  subnet_ids = [
    "${oci_core_subnet.subnet_pubblica.id}","${oci_core_subnet.subnet_pubblica2.id}"
  ]

  display_name = "LOAD BALANCER PUBLIC"
}

resource "oci_load_balancer_backend_set" "lb-bes1" {
  name             = "lb-bes1"
  load_balancer_id = "${oci_load_balancer.load_balancer_public.id}"
  policy           = "IP_HASH"

  health_checker {
    port                = "80"
    protocol            = "TCP"
    #response_body_regex = ".*"
    #url_path            = ""
  }

}

#resource "oci_load_balancer_certificate" "lb-cert1" {
#  load_balancer_id   = "${oci_load_balancer.load_balancer_public.id}"
#  ca_certificate     = "-----BEGIN CERTIFICATE-----\nMIIBNzCB4gIJAKtwJkxUgNpzMA0GCSqGSIb3DQEBCwUAMCMxITAfBgNVBAoTGElu\ndGVybmV0IFdpZGdpdHMgUHR5IEx0ZDAeFw0xNzA0MTIyMTU3NTZaFw0xODA0MTIy\nMTU3NTZaMCMxITAfBgNVBAoTGEludGVybmV0IFdpZGdpdHMgUHR5IEx0ZDBcMA0G\nCSqGSIb3DQEBAQUAA0sAMEgCQQDlM8lz3BFJA6zBlsF63k9ajPVq3Q1WQoHQ3j35\n08DRKIfwqfV+CxL63W3dZrwL4TrjqorP5CQ36+I6OWALH2zVAgMBAAEwDQYJKoZI\nhvcNAQELBQADQQCEjHVQJoiiVpIIvDWF+4YDRReVuwzrvq2xduWw7CIsDWlYuGZT\nQKVY6tnTy2XpoUk0fqUvMB/M2HGQ1WqZGHs6\n-----END CERTIFICATE-----"
#  certificate_name   = "certificate1"
#  private_key        = "-----BEGIN RSA PRIVATE KEY-----\nMIIBOgIBAAJBAOUzyXPcEUkDrMGWwXreT1qM9WrdDVZCgdDePfnTwNEoh/Cp9X4L\nEvrdbd1mvAvhOuOqis/kJDfr4jo5YAsfbNUCAwEAAQJAJz8k4bfvJceBT2zXGIj0\noZa9d1z+qaSdwfwsNJkzzRyGkj/j8yv5FV7KNdSfsBbStlcuxUm4i9o5LXhIA+iQ\ngQIhAPzStAN8+Rz3dWKTjRWuCfy+Pwcmyjl3pkMPSiXzgSJlAiEA6BUZWHP0b542\nu8AizBT3b3xKr1AH2nkIx9OHq7F/QbECIHzqqpDypa8/QVuUZegpVrvvT/r7mn1s\nddS6cDtyJgLVAiEA1Z5OFQeuL2sekBRbMyP9WOW7zMBKakLL3TqL/3JCYxECIAkG\nl96uo1MjK/66X5zQXBG7F2DN2CbcYEz0r3c3vvfq\n-----END RSA PRIVATE KEY-----"
#  public_certificate = "-----BEGIN CERTIFICATE-----\nMIIBNzCB4gIJAKtwJkxUgNpzMA0GCSqGSIb3DQEBCwUAMCMxITAfBgNVBAoTGElu\ndGVybmV0IFdpZGdpdHMgUHR5IEx0ZDAeFw0xNzA0MTIyMTU3NTZaFw0xODA0MTIy\nMTU3NTZaMCMxITAfBgNVBAoTGEludGVybmV0IFdpZGdpdHMgUHR5IEx0ZDBcMA0G\nCSqGSIb3DQEBAQUAA0sAMEgCQQDlM8lz3BFJA6zBlsF63k9ajPVq3Q1WQoHQ3j35\n08DRKIfwqfV+CxL63W3dZrwL4TrjqorP5CQ36+I6OWALH2zVAgMBAAEwDQYJKoZI\nhvcNAQELBQADQQCEjHVQJoiiVpIIvDWF+4YDRReVuwzrvq2xduWw7CIsDWlYuGZT\nQKVY6tnTy2XpoUk0fqUvMB/M2HGQ1WqZGHs6\n-----END CERTIFICATE-----"

 # lifecycle {
  #  create_before_destroy = true
  #}
#}


#resource "oci_load_balancer_hostname" "test_server" {
 # #Required
 # hostname         = "app.example.com"
 # load_balancer_id = "${oci_load_balancer.load_balancer_public.id}"
 # name             = "HOST 1"
#}

#resource "oci_load_balancer_hostname" "test_server2" {
  #Required
 # hostname         = "app2.example.com"
 # load_balancer_id = "${oci_load_balancer.load_balancer_public.id}"
 # name             = "HOST 2"
#}

#resource "oci_load_balancer_path_route_set" "test_path_route_set" {
  #Required
 # load_balancer_id = "${oci_load_balancer.load_balancer_public.id}"
 # name             = "pr-set1"

 # path_routes {
 #   #Required
  #  backend_set_name = "${oci_load_balancer_backend_set.lb-bes1.name}"
   # path             = "/example/video/123"

   # path_match_type {
    #  #Required
     # match_type = "EXACT_MATCH"
    #}
  #}
#}





resource "oci_load_balancer_listener" "lb-listener1" {
  load_balancer_id         = "${oci_load_balancer.load_balancer_public.id}"
  name                     = "http"
  default_backend_set_name = "${oci_load_balancer_backend_set.lb-bes1.name}"
 # hostname_names           = ["${oci_load_balancer_hostname.test_server.name}", "${oci_load_balancer_hostname.test_server2.name}"]
  port                     = 80
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}

#resource "oci_load_balancer_listener" "lb-listener2" {
 # load_balancer_id         = "${oci_load_balancer.load_balancer_public.id}"
 # name                     = "https"
 # default_backend_set_name = "${oci_load_balancer_backend_set.lb-bes1.name}"
 # port                     = 443
 # protocol                 = "HTTP"

 # ssl_configuration {
  #  certificate_name        = "${oci_load_balancer_certificate.lb-cert1.certificate_name}"
   # verify_peer_certificate = false
 # }
#}

resource "oci_load_balancer_backend" "lb-be1" {
  load_balancer_id = "${oci_load_balancer.load_balancer_public.id}"
  backendset_name  = "${oci_load_balancer_backend_set.lb-bes1.name}"
  ip_address       = "${oci_core_instance.compute_apache.public_ip}"
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "lb-be2" {
  load_balancer_id = "${oci_load_balancer.load_balancer_public.id}"
  backendset_name  = "${oci_load_balancer_backend_set.lb-bes1.name}"
  ip_address       = "${oci_core_instance.compute_server.public_ip}"
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

output "Load Balancer Front-End" {
value="${oci_load_balancer.load_balancer_public.ip_addresses[0]}"

}
