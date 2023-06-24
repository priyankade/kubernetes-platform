module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "eks-cluster"
  cluster_version = "1.27"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   =  module.vpc.vpc_id
  subnet_ids               =  module.vpc.private_subnets
  control_plane_subnet_ids =  module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t2.micro"]
  }

  eks_managed_node_groups = {
    # blue = {}
    green = {
      min_size     = 1
      max_size     = 1
      desired_size = 1

      capacity_type  = "SPOT"
    }
  }

#   # aws-auth configmap
#   manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::406286632660:role/aws-service-role/eks.amazonaws.com/AWSServiceRoleForAmazonEKS"
      username = "AWSServiceRoleForAmazonEKS"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::406286632660:user/priyade"
      username = "priyade"
      groups   = ["system:masters"]
    }

  ]

#   aws_auth_accounts = [
#     "777777777777",
#     "888888888888",
#   ]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}