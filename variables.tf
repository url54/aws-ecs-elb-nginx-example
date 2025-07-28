variable "project_name" {
  description = "The name of the project."
  type        = string
  default     = "nginx-webapp"
}

variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets."
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "Availability Zones to use."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "container_image_uri" {
  description = "The URI of the Docker image to deploy in ECS."
  type        = string
  default     = "nginx:latest" # Using the official NGINX image
}