resource "aws_vpc" "Agent" {
  cidr_block = "10.10.0.0/16"

tags = {
    Name = "Azure_Agent"
  }
}

resource "aws_subnet" "Zone1" {
  vpc_id     = aws_vpc.Agent.id
  cidr_block = "10.10.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Public_Agent"
  }
}

resource "aws_security_group" "eks_sg" {
  name        = "eks-security-group"
  description = "Security group for EKS cluster and node group"
  vpc_id      = aws_vpc.Agent.id

  # Allow inbound traffic on port 80 (HTTP)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Security_Group_A"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Agent.id
  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "RouteTable" {
  vpc_id = aws_vpc.Agent.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "RouteTable"
  }
}

resource "aws_route_table_association" "az1" {
  subnet_id      = aws_subnet.Zone1.id
  route_table_id = aws_route_table.RouteTable.id
}
