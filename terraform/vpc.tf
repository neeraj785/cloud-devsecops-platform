module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.project_name}-vpc"
  cidr = "10.0.0.0/16"

  azs            = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  # Disable NAT Gateway completely ($0 cost)
  enable_nat_gateway = false
  single_nat_gateway = false

  enable_dns_hostnames = true

  # Tag public subnets so Kubernetes Load Balancers can deploy here
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
}
