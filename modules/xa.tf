# XA modules

# Import the VPC module
module "xa_vpc" {
  source = "github.com/cldcvr/cldcvr-xa-terraform-aws-vpc?ref=v0.1.0"
}

# Import the Security Group module
module "xa_security_group" {
  source = "github.com/cldcvr/cldcvr-xa-terraform-aws-security-group?ref=v0.1.0"
}

# Import the EC2 Instance module
module "xa_ec2_instance" {
  source = "github.com/cldcvr/cldcvr-xa-terraform-aws-ec2-instance-module?ref=v0.1.0"
}

# Import the RDS Database Instance module
module "xa_db_instance" {
  source = "github.com/cldcvr/cldcvr-xa-terraform-aws-db-instance?ref=v0.1.0"
}

# Import the S3 Bucket module
module "xa_s3_bucket" {
  source = "github.com/cldcvr/cldcvr-xa-terraform-aws-s3-bucket?ref=v0.1.0"
}

# Import the Key Pair module
module "xa_key_pair" {
  source = "github.com/cldcvr/cldcvr-xa-terraform-aws-key-pair?ref=v0.1.0"
}

# Import the elastic cache cluster module
module "xa_elasticache_cluster" {
  source = "github.com/cldcvr/cldcvr-xa-terraform-aws-elasticache-cluster?ref=v0.1.0"
}

# Import the ECR Repository module
module "xa_ecr_repository" {
  source = "github.com/cldcvr/cldcvr-xa-terraform-aws-ecr-repository"
}

# Import the Route53 Zone module
module "xa_route53_zone" {
  source = "github.com/cldcvr/cldcvr-xa-terraform-aws-route53-zone?ref=v0.1.0"
}

# Import the aws iam role module
module "xa_aws_iam_role" {
  source = "github.com/cldcvr/cldcvr-xa-terraform-aws-iam-role?ref=v0.1.0"
}

# Import the EKS Cluster module
module "xa_eks_cluster" {
  source = "github.com/cldcvr/cldcvr-xa-terraform-aws-eks-cluster?ref=pranay%2FawsVersionMismatch"
}
