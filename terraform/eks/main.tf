resource "aws_eks_cluster" "main" {
  name     = "mohan_eks"
  role_arn = ""  # Set role ARN to empty string

  vpc_config {
    subnet_ids = var.private_subnet_ids
  }
}

resource "aws_security_group" "eks_cluster" {
  name        = "eks_cluster_sg"
  description = "EKS Cluster security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


