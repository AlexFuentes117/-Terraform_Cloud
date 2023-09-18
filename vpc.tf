resource "aws_vpc" "vpc-virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    Name = "VPC_Virgina-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc-virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_Subnet-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc-virginia.id
  cidr_block = var.subnets[1]
  tags = {
    Name = "Private_Subnet-${local.sufix}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-virginia.id
  tags = {
    Name = "IGW VPC Virginia-${local.sufix}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc-virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table-${local.sufix}"
  }
}

resource "aws_route_table_association" "Route_Table_Association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "SG_Public_Instance" {
  name        = "SG Public Instance"
  description = "Allow SHH inbound traffic and all egress traffic"
  vpc_id      = aws_vpc.vpc-virginia.id

  # ingress {
  #   description = "SSH over Internet"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }

  dynamic "ingress" {
    for_each = var.ingress_port_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]

    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "SG Public Instance-${local.sufix}"
  }
}
