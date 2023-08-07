# Public modules

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.31.2"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.1.1"
}

module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "1.5.0"
}


