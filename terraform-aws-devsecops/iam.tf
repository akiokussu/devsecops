# IAM Role for Web Application Server
resource "aws_iam_role" "web_app_role" {
  name = "web_app_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com",
        },
        Effect = "Allow",
        Sid = "",
      },
    ],
  })
}

# IAM Policy for ECR Read Access for the Web Application Server
resource "aws_iam_policy" "ecr_read_policy" {
  name        = "ECRReadAccessPolicy"
  description = "Policy grants access to ECR for pulling Docker images"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect: "Allow",
        Action: [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ],
        Resource: "arn:aws:ecr:eu-central-1:986505030570:repository/your-repository-name"
      },
      {
        Effect: "Allow",
        Action: [
          "ecr:GetAuthorizationToken"
        ],
        Resource: "*"
      }
    ]
  })
}

# Attach the ECR Read Access Policy to the Web Application Server's IAM Role
resource "aws_iam_role_policy_attachment" "web_app_ecr_read_policy_attachment" {
  role       = aws_iam_role.web_app_role.name
  policy_arn = aws_iam_policy.ecr_read_policy.arn
}

# Instance Profile for Web Application Server
resource "aws_iam_instance_profile" "web_app_profile" {
  name = "web_app_profile"
  role = aws_iam_role.web_app_role.name
}

# IAM Role for Jenkins Server
resource "aws_iam_role" "jenkins_role" {
  name = "jenkins_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com",
        },
        Effect = "Allow",
        Sid = "",
      },
    ],
  })
}

# IAM Policy for Jenkins Server 
resource "aws_iam_policy" "jenkins_policy" {
  name        = "jenkins_policy"
  description = "A more restrictive policy for Jenkins server"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          // permissions for ECR
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart",
        ],
        Effect   = "Allow",
        Resource = "arn:aws:ecr:eu-central-1:986505030570:repository/webapp-devsecops"
      },
    ],
  })
}

# Attach the Policy to the Role for Jenkins Server
resource "aws_iam_role_policy_attachment" "jenkins_attach" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = aws_iam_policy.jenkins_policy.arn
}

# Instance Profile for Jenkins Server
resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins_profile"
  role = aws_iam_role.jenkins_role.name
}