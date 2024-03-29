#TOO restricted?
# NACL for Public Subnet
resource "aws_network_acl" "public_nacl" {
  vpc_id = aws_vpc.devsecops_vpc.id
  tags = {
    Name = "public_nacl"
  }
}

# Allow HTTPS and SSH inbound on Public NACL
resource "aws_network_acl_rule" "public_inbound_https" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 100
  rule_action    = "allow"
  egress         = false
  protocol       = "tcp"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "public_inbound_ssh" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 110
  rule_action    = "allow"
  egress         = false
  protocol       = "tcp"
  # My home ip 
  cidr_block     = "77.126.22.18/32"
  from_port      = 22
  to_port        = 22
}

# Allow all outbound traffic on Public NACL
resource "aws_network_acl_rule" "public_outbound_all" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 100
  rule_action    = "allow"
  egress         = true
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

# Associate Public NACL with Public Subnet
resource "aws_network_acl_association" "public_nacl_association" {
  network_acl_id = aws_network_acl.public_nacl.id
  subnet_id      = aws_subnet.public_subnet.id
}

# NACL for Private Subnet
resource "aws_network_acl" "private_nacl" {
  vpc_id = aws_vpc.devsecops_vpc.id
  tags = {
    Name = "private_nacl"
  }
}

# Allow SSH
resource "aws_network_acl_rule" "private_inbound_ssh" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 100
  rule_action    = "allow"
  egress         = false
  protocol       = "tcp"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

# Allow all outbound traffic on Private NACL
resource "aws_network_acl_rule" "private_outbound_all" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 100
  rule_action    = "allow"
  egress         = true
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

# Associate Private NACL with Private Subnet
resource "aws_network_acl_association" "private_nacl_association" {
  network_acl_id = aws_network_acl.private_nacl.id
  subnet_id      = aws_subnet.private_subnet.id
}