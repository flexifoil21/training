variable "dnsimple_token" {
  type = "string"
  default = "sampleToken"
}

variable "dnsimple_email" {
  type = "string"
  default = "russ@gnsd.net"
}

# Configure the DNSimple provider
provider "dnsimple" {
    token = "${var.dnsimple_token}"
    email = "${var.dnsimple_email}"
}

# Create a record
resource "dnsimple_record" "www" {
    domain = "terraform.rocks"
    name = "boogers"
    value = "${aws_instance.web.0.public_ip}"
    type = "A"
}

