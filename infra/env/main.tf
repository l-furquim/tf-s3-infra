module "prod" {
  source = "../infra"

  aws_region = "us-east-1"
  ec2_name = "ProductionInstance"
  iam_role = "production"
  nome_repositorio = "production"
  ambiente= "productionproducao"
}