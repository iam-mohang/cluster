variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_cluster_version" {
  description = "Version of the EKS cluster"
  type        = string
  default     = "1.21"  # Example version, change as needed
}

variable "eks_instance_type" {
  description = "Instance type for the EKS worker nodes"
  type        = string
  default     = "t3.medium"  # Example instance type, change as needed
}

variable "eks_node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "eks_node_group_desired_capacity" {
  description = "Desired capacity of the EKS node group"
  type        = number
  default     = 2  # Example desired capacity, change as needed
}

variable "eks_node_group_max_capacity" {
  description = "Maximum capacity of the EKS node group"
  type        = number
  default     = 10  # Example maximum capacity, change as needed
}

variable "eks_node_group_min_capacity" {
  description = "Minimum capacity of the EKS node group"
  type        = number
  default     = 1  # Example minimum capacity, change as needed
}

