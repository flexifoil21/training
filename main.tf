#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-7e50c21a
#
# Your security group ID is:
#
#     sg-29ef374e
#
# Your AMI ID is:
#
#     ami-30217250
#
# Your Identity is:
#
#     autodesk-coyote
#

variable "aws_access_key" {
  type    = "string"
}

variable "aws_secret_key" {
  type    = "string"
}

variable "aws_region" {
  type = "string"
  default = "us-west-1"
}

variable "num_webs" {
  default = "2"
}

#module "example" {
#  source = "./example-module"
#  command = "echo 'Goodbye Cruel World'"
#}

provider "aws" {
  #  access_key = "AKIAJ4T6XBFPVNSXAMJQ"
  #  secret_key = "N1ybeKZEk9EgWzrRu7oYGzWG5o4wcBsgOuCJoMlH"
  #  region     = "us-west-1"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-30217250"
  instance_type          = "t2.micro"
  count			 = "3"
  subnet_id              = "subnet-7e50c21a"
  vpc_security_group_ids = ["sg-29ef374e"]

  tags {
    Identity = "autodesk-coyote"
    Name     = "web ${count.index+1} of ${var.num_webs}"
    Blah     = "BlahBlah"
    OneMore  = "Something"
  }
}

output "public_dns" {
    value = "${aws_instance.web.public_dns}"
}
output "public_ip" {
    value = "${aws_instance.web.0.public_ip}"
}
output "all_ip" {
    value = ["${aws_instance.web.*.public_ip}"]
#}
