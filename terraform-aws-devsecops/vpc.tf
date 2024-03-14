resource "aws_vpc" "devsecops_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "DevSecOpsVPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.devsecops_vpc.id

  tags = {
    Name = "myVPC-igw"
  }
}

# Enable VPC Flow Logs for traffic monitoring IF NEEDED 
# resource "aws_flow_log" "vpc_flow_log" {
#   iam_role_arn    = aws_iam_role.flow_log_role.arn  
#   log_destination = aws_cloudwatch_log_group.vpc_flow_log_group.arn  
#   traffic_type    = "ALL"
#   vpc_id          = aws_vpc.devsecops_vpc.id
# }