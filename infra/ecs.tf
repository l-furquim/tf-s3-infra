module "ecs" {
  source = "terraform-aws-modules/ecs/aws"
    cluster_name               = var.env
    autoscaling_capacity_providers = [
      {
        capacity_provider = "FARGATE"
        weight            = 1
      }
    ] 
    tags = {
      Environment = var.env
    }
  }


resource "aws_ecs_task_definition" "wefood-api" {
  family                   = "wefood-api"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.role.arn
  container_definitions    = jsonencode(
	[
	  {
	    "name" =  "production"
	    "image" =  "mudar para o nome da imagem"
	    "cpu" =  256
	    "memory" = 512
	    "essential" = true
	    "portMappings" = [
		    {
			    "containerPort" = 8080
			    "hostPort" = 8080
			  }
			] 
	  }
	]
)
}
resource "aws_ecs_service" "wefood-api" {
  name            = "wefood-api"
  task_definition = aws_ecs_task_definition.wefood-api.arn
  // Validar isso desired_count   = 3

  network_configuration {
      subnets = module.vpc.private_subnets
      security_groups = [aws_security_group.private.id]
  }

  capacity_provider_strategy {
      capacity_provider = "FARGATE"
      weight = 1 #100/100
  }
}