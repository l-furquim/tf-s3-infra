resource "aws_iam_role" "role" {
  name = "${var.iam_role}_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = ["ec2.amazonaws.com", "ecs-tasks.amazonaws.com"]
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_policy" "ecs_ecr" {
  name   = "ecs_ecr"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "ecs_ecr_attachment" {
  policy_arn = aws_iam_policy.ecs_ecr.arn
  role       = aws_iam_role.ecs_role.name
}

resource "aws_iam_instance_profile" "ecs_profile" {
  name = "${var.iam_role}_profile"
  role = aws_iam_role.ecs_role.name
}
