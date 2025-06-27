# 1. VPC

resource "aws_vpc" "as3vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "wordpress-vpc"
  }
}

# 2. Internet gateway

resource "aws_internet_gateway" "as3igw" {
  vpc_id = aws_vpc.as3vpc.id

  tags = {
    Name = "wordpress_igw"
  }
}

# 3. Route table

resource "aws_route_table" "as3rt" {
  vpc_id = aws_vpc.as3vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.as3igw.id
  }

  tags = {
    Name = "wordpress-rt"
  }
}

# 4. Subnets

resource "aws_subnet" "as3sub1" {
  vpc_id     = aws_vpc.as3vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true 

  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "as3sub2" {
  vpc_id     = aws_vpc.as3vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"


  tags = {
    Name = "public2"
  }
}
resource "aws_subnet" "as3sub3" {
  vpc_id     = aws_vpc.as3vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "public3"
  }
}
resource "aws_subnet" "as3sub4" {
  vpc_id     = aws_vpc.as3vpc.id
  cidr_block = "10.0.101.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private1"
  }
}

resource "aws_subnet" "as3sub5" {
  vpc_id     = aws_vpc.as3vpc.id
  cidr_block = "10.0.102.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private2"
  }
}

resource "aws_subnet" "as3sub6" {
  vpc_id     = aws_vpc.as3vpc.id
  cidr_block = "10.0.103.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "private3"
  }
}


# 5. Route table association

resource "aws_route_table_association" "public1_assoc" {
  subnet_id      = aws_subnet.as3sub1.id
  route_table_id = aws_route_table.as3rt.id
}

resource "aws_route_table_association" "public2_assoc" {
  subnet_id      = aws_subnet.as3sub2.id
  route_table_id = aws_route_table.as3rt.id
}

resource "aws_route_table_association" "public3_assoc" {
  subnet_id      = aws_subnet.as3sub3.id
  route_table_id = aws_route_table.as3rt.id
}


# 6. Security Group

resource "aws_security_group" "wordpress_sg" {
  name        = "wordpress-sg"
  description = "Allow HTTP, HTTPS, SSH"
  vpc_id      = aws_vpc.as3vpc.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wordpress-sg"
  }
}