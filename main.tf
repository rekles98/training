#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-66506c1c
#
# Your subnet ID is:
#
#     subnet-ce92e593
#
# Your security group ID is:
#
#     sg-3ee83749
#
# Your Identity is:
#
#     customer-training-ape
#

variable "aws_access_key" {
  type = "string"
}
variable "aws_secret_key" {
  type = "string"
}
variable "aws_region" {
  type    = "string"
  default = "us-east-1"
}

provider "aws" {
   access_key = "${var.aws_access_key}"
   secret_key = "${var.aws_secret_key}"
   region     = "${var.aws_region}"
}

terraform {
  backend "atlas" {
    name = "rekles98/training"
  }
}

resource "aws_instance" "web" {
  ami                    = "ami-66506c1c"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-ce92e593"
  vpc_security_group_ids = ["sg-3ee83749"]
  count = "2"
  tags {
    "Identity" = "customer-training-ape"
    "Name"     = "web"
    "Date"     = "January 31st, 2018"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
