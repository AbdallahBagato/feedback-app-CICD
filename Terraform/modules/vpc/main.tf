resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.cluster_name}-vpc"
    "kubernates.io/cluster/${var.cluster_name}" = "shared"  ## Owned It mean only one Eks per Vpc and share can be Multi Eks per vpc 
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = element(var.availability_zones, count.index) ##It mean the if number of AZ less than subnets it will repeate 
  tags = {
    Name = "${var.cluster_name}-private-${count.index + 1}"
    "kubernates.io/cluster/${var.cluster_name}" = "shared"
    "kubernates.io/role/internal-elb" = "1"
    }
}

resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidr)
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr[count.index]
    tags = {
        Name = "${var.cluster_name}-public-${count.index + 1}"
        "kubernates.io/cluster/${var.cluster_name}" = "shared"
        "kubernates.io/role/elb" = "1"
    }
}
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.cluster_name}-igw"
  }
}

resource "aws_route_table" "RouteTable" {
  count = length(var.public_subnet_cidr)
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${var.cluster_name}-public-route-table-${count.index +1}"
  }
}
resource "aws_route_table_association" "public_association" {
  count = length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.RouteTable[count.index].id
}


resource "aws_eip" "nat_eip" {
  count = length(var.public_subnet_cidr)
  tags = {
    Name = "EIP_${var.cluster_name}-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "example" {
  count = length(var.public_subnet_cidr)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = {
    Name = "NatGateway-${var.cluster_name}-${count.index + 1}"
  }
}


resource "aws_route_table" "private_route_table" {
  count = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.example[count.index].id
  }
  tags = {
    Name = "${var.cluster_name}-private-route-table-${count.index + 1}"
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr) ## This will associate all the public subnet to this route table
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}