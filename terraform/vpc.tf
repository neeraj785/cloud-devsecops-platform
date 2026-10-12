data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.project_name}-vpc"
  cidr = "10.0.0.0/16"

  azs            = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  # No NAT gateway: nodes run in public subnets (fine for practice, not production)
  enable_nat_gateway = false
  single_nat_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  # Nodes in public subnets need public IPs to reach the internet and join the cluster
  map_public_ip_on_launch = true

  # Tag public subnets so Kubernetes load balancers can deploy here
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
}
