# VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      name = "${var.name}-vpc"
    },
    var.custom_tags
  )
}

# Subnet pubblica (singola)
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.vpc_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = merge(
    {
      name = "${var.name}-public-subnet"
    },
    var.custom_tags
  )
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      name = "${var.name}-igw"
    },
    var.custom_tags
  )
}

# Route Table pubblica
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      name = "${var.name}-public-rt"
    },
    var.custom_tags
  )
}

# Route per l'accesso a Internet
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

# Associazione della Route Table alla Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Availability Zones (necessaria per prendere almeno una zona valida)
data "aws_availability_zones" "available" {}
