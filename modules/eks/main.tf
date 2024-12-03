module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.name_prefix}-eks"
  cluster_version = "1.31"
  cluster_endpoint_public_access = var.cluster_endpoint_public_access

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnets
  control_plane_subnet_ids = var.control_plane_subnets

  # EKS Managed Node Group Defaults
  eks_managed_node_group_defaults = {
    instance_types       = ["t3.small", "t3a.small", "t4g.small", "t3.nano", "t3.micro"]
    spot_instance_pools  = 2  # Number of instance types to consider for Spot
  }

  # EKS Managed Node Groups
  eks_managed_node_groups = {
    
    # On-Demand Node Group
    # on_demand = {
    #   ami_type       = "AL2023_x86_64_STANDARD"
    #   instance_types = ["t3.small", "t3a.small", "t4g.small"]  # Small instances for cost-efficiency
    #   min_size       = 1
    #   max_size       = 3
    #   desired_size   = 1
    #   capacity_type  = "ON_DEMAND"  # Ensures this node group uses On-Demand instances
    # }

    # Spot Node Group
      spot_group = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types       = ["t3.small", "t3a.small", "t4g.small", "t3.nano", "t3.micro"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
      capacity_type  = "SPOT"  # Use Spot Instances for this group to reduce costs
    }
  }

  # Cluster access entry
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
  access_entries = {
    example = {
      principal_arn = "arn:aws:iam::123456789012:role/something"
      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
          access_scope = {
            namespaces = ["default"]
            type       = "namespace"
          }
        }
      }
    }
  }

  tags = var.tags
}
