module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "harsh-viradia-vpc"
  cidr = var.vpc_cidr

  azs = var.azs

  private_subnets      = var.private_cidr
  private_subnet_names = var.private_subnet_names

  public_subnets      = var.public_cidr
  public_subnet_names = var.public_subnet_names

  enable_dns_support   = true
  enable_dns_hostnames = true

  default_route_table_tags = {
    Name = "harsh-viradia-default-rt"
  }
  public_route_table_tags  = {
    Name = "harsh-viradia-public-rt"
  }
  private_route_table_tags = {
    Name = "harsh-viradia-private-rt"
  }

  # One NAT per AZ
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  nat_gateway_tags       = {
    Name = "harsh-viradia-nat-gateway"
  }

  igw_tags = {
    Name = "harsh-viradia-igw"
  }

  tags = {
    Owner = "harsh.viradia@intuitive.cloud"
  }
}