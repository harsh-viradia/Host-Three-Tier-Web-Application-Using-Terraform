data "aws_ami" "web_ami" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }
}

data "aws_route53_zone" "private_zone" {
  name = "dns-poc-onprem.tk"
  private_zone=true
}


data "aws_route53_zone" "public_zone" {
  name = "dns-poc-onprem.tk"
  private_zone = false
}
data "aws_acm_certificate" "https_certificate" {
  domain = "dns-poc-onprem.tk"
  statuses = ["ISSUED"]
}
