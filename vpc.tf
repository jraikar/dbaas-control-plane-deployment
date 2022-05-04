data "aws_availability_zones" "azs" {}

module "vpc" {

    source = "terraform-aws-modules/vpc/aws"
    version = "3.7.0"
    name = "dbaas-vpc"
    cidr = var.vpc_cidr_blocks
    azs = data.aws_availability_zones.azs.names
    private_subnets = var.private_subnets_cidr_blocks
    public_subnets = var.public_subnets_cidr_blocks

    enable_dns_hostnames = true
    enable_nat_gateway = true
    single_nat_gateway = true

    public_subnet_tags = {
        "kubernetes.io/cluster/${local.cluster_name}" = "shared"
        "kubernetes.io/role/elb" = "1"
    }

    private_subnet_tags = {
      "kubernetes.io/cluster/${local.cluster_name}" = "shared"
      "kubernetes.io/role/internal-elb" = "1"
    }

}
