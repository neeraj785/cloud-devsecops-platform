module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.project_name}-eks"
  cluster_version = "1.30"

  cluster_endpoint_public_access = true

  create_cloudwatch_log_group = false
  create_kms_key              = false
  cluster_encryption_config   = {}

  vpc_id     = module.vpc.vpc_id
  # Put the cluster and nodes in public subnets:
  subnet_ids = module.vpc.public_subnets

  eks_managed_node_groups = {
    spot_workers = {
      name = "workers"

      # Subnet where the worker EC2 instances will run
      subnet_ids = module.vpc.public_subnets

      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"

      min_size     = 1
      max_size     = 2
      desired_size = 1

      iam_role_use_name_prefix = false
      iam_role_name            = "${var.project_name}-node-role"
    }
  }
}
