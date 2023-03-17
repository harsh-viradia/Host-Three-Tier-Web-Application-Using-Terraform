variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "public_cidr" {
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "private_cidr" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "https_certificate" {
  default = "arn:aws:acm:us-east-1:587172484624:certificate/4a382046-f0f6-4203-bfe5-a6319c62c318"
}

variable "tags" {
  type = map(string)
  default = {
    Name  = "harsh-viradia"
    Owner = "harsh.viradia@intuitive.cloud"
  }
}

variable "iam_role_asg" {
  default = {
    AmazonSSMFullAccess = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
  }
}

variable "route53_public_zone_id" {
  default = "Z09694789KLKEHOHJN0T"
}
variable "route53_private_zone_id" {
  default = "Z09600291FQN85FFRHCOB"
}
variable "record_type" {
  default = "CNAME"
}
variable "route53_ttl" {
  default = 300
}

variable "private_subnet_names" {
  default = ["harsh-viradia-privateA", "harsh-viradia-privateB", "harsh-viradia-privateC", "harsh-viradia-privateD", "harsh-viradia-privateE", "harsh-viradia-privateF"]
}
variable "public_subnet_names" {
  default = ["harsh-viradia-publicA", "harsh-viradia-publicB", "harsh-viradia-publicC"]
}

variable "iam_role_name_ssm_asg" {
  default = "gaurav-ec2-ssm"
}
