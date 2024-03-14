
# Web App 
resource "aws_instance" "web_app_instance" {
  ami           = "ami-08d4ac5b634553e16" # Ubuntu 22.04 in eu-central-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.web_app_sg.id]
  iam_instance_profile = aws_iam_instance_profile.web_app_profile.name
  key_name      = "amazonhomelab"

  root_block_device {
    encrypted = true
  }

  ebs_block_device {
    device_name = "/dev/sdh"
    encrypted   = true
  }
  
  tags = {
    Name = "WebAppServer"
  }
  
}
# Jenkins Server 
resource "aws_instance" "jenkins_instance" {
  ami           = "ami-08d4ac5b634553e16" # Ubuntu 22.04 in eu-central-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.jenkins_profile.name
  key_name      = "amazonhomelab"

  root_block_device {
    encrypted = true
  }

  ebs_block_device {
    device_name = "/dev/sdh"
    encrypted   = true
  }

  tags = {
    Name = "JenkinsServer"
  }
}

# Nginx Server and a self-signed certificate
resource "aws_instance" "nginx_instance" {
  ami                    = "ami-08d4ac5b634553e16" # Ubuntu 22.04 in eu-central-1
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  key_name      = "amazonhomelab"

  root_block_device {
    encrypted = true
  }

  ebs_block_device {
    device_name = "/dev/sdh"
    encrypted   = true
  }

  tags = {
    Name = "NginxServer"
  }

}
# Jump server for testing purposes and management
resource "aws_instance" "bastion_host" {
  ami           = "ami-08d4ac5b634553e16"  
  instance_type = "t2.micro"
  key_name      = "amazonhomelab" 
  subnet_id     = aws_subnet.public_subnet.id  
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  root_block_device {
    encrypted = true
  }

  ebs_block_device {
    device_name = "/dev/sdh"
    encrypted   = true
  }

  tags = {
    Name = "BastionHost"
  }
}
