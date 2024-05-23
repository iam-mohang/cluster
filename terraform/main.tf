provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnets, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count      = length(var.private_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.private_subnets, count.index)

  tags = {
    Name = "private-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "18.0.0" # Make sure this matches the latest stable version or the version you intend to use
  cluster_name    = var.cluster_name
  cluster_version = "1.22"
  subnet_ids      = aws_subnet.private[*].id
  vpc_id          = aws_vpc.main.id
}

module "eks_node_group" {
  source          = "terraform-aws-modules/eks/aws//modules/node_group"
  cluster_name    = module.eks.cluster_id
  cluster_version = "1.22"
  subnet_ids      = aws_subnet.private[*].id
  node_group_name = "eks_nodes"
  node_group_defaults = {
    instance_type    = "t3.medium"
    desired_capacity = 2
    max_capacity     = 3
    min_capacity     = 1
  }

  key_name = "my-key"  # Replace with your key name
}



