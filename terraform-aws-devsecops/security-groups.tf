# Nginx Security Group
resource "aws_security_group" "nginx_sg" {
  vpc_id = aws_vpc.devsecops_vpc.id
  name   = "nginx_sg"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # For management purpose
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
    description = "SSH access from Bastion Host"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx_sg"
  }
}

# Web App Security Group
resource "aws_security_group" "web_app_sg" {
  vpc_id = aws_vpc.devsecops_vpc.id
  name   = "web_app_sg"

  # Allow Only NGINX
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.nginx_sg.id]
  }

  # Allow Jenkins to deploy updates
  ingress {
    from_port       = 22 
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_sg.id]
  }
  # From Bastion Host for management
  ingress {
    from_port       = 22 
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
    description     = "SSH access from Bastion Host"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_app_sg"
  }
}

# Jenkins Security Group
resource "aws_security_group" "jenkins_sg" {
  vpc_id = aws_vpc.devsecops_vpc.id
  name   = "jenkins_sg"

  # From Bastion Host for management
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
    description     = "SSH access from Bastion Host"
  }

  # allow HTTP traffic on port 8080 from Bastion SG
  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
    description     = "HTTP access from Bastion Host on port 8080"
  }

  # Jenkins needs internet access to pull code/build tools
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins_sg"
  }
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "Security group for SSH access to the bastion host"
  vpc_id      = aws_vpc.devsecops_vpc.id  

  # Only my IP allowed
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["77.126.22.18/32"] 
    description = "Aleksey HOME"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion_sg"
  }
}