data "aws_eks_cluster" "cluster" {
    name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
    name = module.eks.cluster_id 
}

locals {
  cluster_name = "control-plane-dbaas-cluster"
}

module "eks" {
    source = "terraform-aws-modules/eks/aws"

    cluster_name = "${local.cluster_name}"
    vpc_id = module.vpc.vpc_id
    cluster_version = "1.21"
    subnet_ids = module.vpc.private_subnets

    eks_managed_node_groups = {
        first_node = {
            desired_capacity = 2
            max_capacity = 10
            min_capacity = 2

            instance_type = "m5.large"
        }
    }
      
}
