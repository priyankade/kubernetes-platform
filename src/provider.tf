terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.13.3"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  #cluster_ca_certificate = base64decode(module.eks.eks_cluster_name.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  # load_config_file       = false
  version = "~> 2.21.1"
}

# For authentication, the Helm provider can get its configuration by supplying a path to your kubeconfig file.
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}