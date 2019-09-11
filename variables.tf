variable "tenancy_ocid" {default="ocid1.tenancy.oc1..aaaaaaaaqxfunbsz2os6qg4lbz2gll5zelye5awfvdav5jpuj5bnsewx6mmq"}
variable "user_ocid" {default="ocid1.user.oc1..aaaaaaaa6wiijtmbw63a63npazny7n5urd4xkrfls5wwyodswfxxyxd3vzga"}
variable "fingerprint" {default="e9:01:06:29:74:1d:74:4f:20:43:8a:3e:ce:e3:64:d1"}
variable "private_key_path" {default="~/.oci/oci_api_key.pem"}
variable "region" {default="eu-frankfurt-1"}

variable "compartment_ocid" {default="ocid1.compartment.oc1..aaaaaaaa5wbxn5b6hrxevpapgc6ezj3hwcropuxozpsqsht5xa6tltwqef6a"}
variable "ssh_public_key" {default="$(cat /home/francesco/.ssh/id_rsa.pub)"}
variable "ssh_private_key" {default="$(cat /home/francesco/.ssh/id_rsa)"}

# Choose an Availability Domain
variable "AD" {
    default = "2"
}

variable "instance_shape" {
  default = "VM.Standard2.1"
}

variable "InstanceImageOCID" {
    type = "map"
    default = {
        // Oracle-provided image "Oracle-Linux-7.4-2017.12.18-0"
        // See https://docs.us-phoenix-1.oraclecloud.com/Content/Resources/Assets/OracleProvidedImageOCIDs.pdf
        us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaa3av7orpsxid6zdpdbreagknmalnt4jge4ixi25cwxx324v6bxt5q"
        us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaaxrqeombwty6jyqgk3fraczdd63bv66xgfsqka4ktr7c57awr3p5a"
        eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaayxmzu6n5hsntq4wlffpb4h6qh6z3uskpbm5v3v4egqlqvwicfbyq"
	uk-london-1 = "ocid1.image.oc1.uk-london-1.aaaaaaaaikjrglbnzkvlkiltzobfvtxmqctoho3tmdcwopnqnoolmwbsk3za"
    }
}

variable "DBSize" {
    default = "50" // size in GBs
}

variable "BootStrapFile" {
    default = "./userdata/bootstrap"
}
