# these modules will not show-up in auto-complete
# these will be used to enrich attribute mappings and relationships between different resources and modules

module "tr-hide-voting-demo" {
  source = "github.com/cldcvr/codepipes-tutorials//voting/infra/aws/eks?ref=terrarium-sources"
}

module "tr-hide-serverless-sample" {
  source = "github.com/cldcvr/codepipes-tutorials//serverless-sample/infra/aws?ref=terrarium-sources"
}

module "tr-hide-wpdemo-eks" {
  source = "github.com/cldcvr/codepipes-tutorials//wpdemo/infra/aws/eks?ref=terrarium-sources"
}

module "tr-hide-wpdemo-ec2" {
  source = "github.com/cldcvr/codepipes-tutorials//wpdemo/infra/aws/ec2?ref=terrarium-sources"
}