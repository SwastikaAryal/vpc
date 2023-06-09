#creating VPC
resource "aws_vpc" "sa_vpc" {
    cidr_block = var.vpc_cidr
    tags ={
        "Name" = "myterraformvpc"
    } 
} 
#creating public and private subnet
resource "aws_subnet" "sa_publicsubnet" {
    vpc_id = aws_vpc.sa_vpc.id
    cidr_block = var.sa_publicsubnet
  tags = {
    "Name" = "sa_public_subnet"
  }
}
resource "aws_subnet" "sa_privatesubnet" {
    vpc_id = aws_vpc.sa_vpc.id
    cidr_block = var.sa_privatesubnet
  tags = {
    "Name" = "sa_private_subnet"
  }
}
#creating Internet gateway
resource "aws_internet_gateway" "sa_igw" {
  vpc_id = aws_vpc.sa_vpc.id
  tags = {
    "Name" = "myterraformigw"
  }
}
#creating a route table for public subnet
resource "aws_route_table" "sa_publicrt" {
    vpc_id = aws_vpc.sa_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sa_igw.id

  }
  tags = {
    "Name" = "sa_public_rt"
  }
}
#creating a public subnet route table association
resource "aws_route_table_association" "sa_publicRTA" {
    subnet_id = aws_subnet.sa_publicsubnet.id
    route_table_id = aws_route_table.sa_publicrt.id
  
}
#creating a elastic ip for Natgateway
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "sa_nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.sa_publicsubnet.id
  depends_on    = [aws_internet_gateway.sa_igw]
}

#creating a route table for private subnet
resource "aws_route_table" "sa_privatert" {
  vpc_id = aws_vpc.sa_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.sa_nat_gw.id
  }

  tags = {
    Name = "sa_private_rt"
  }
}

#creating a private subnet route table association
resource "aws_route_table_association" "sa_privateRTA" {
  subnet_id      = aws_subnet.sa_privatesubnet.id
  route_table_id = aws_route_table.sa_privatert.id
}
