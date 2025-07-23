variable "cluster_name" {
    description = "The name of the EKS cluster"
    type        = string
    default     = "example-cluster"
}

variable "admin_acess" {
    description = "Enable admin access for the bootstrap cluster creator"
    type        = bool
    default     = true
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.31"
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "max_size" {
    description = "The maximum number of nodes in the EKS node group"
    type        = number
    default     = 3
}
variable "min_size" {
    description = "The Maximum number of nodes for eks node group"
    type = number
    default = 2
}
variable "desired_size" {
    description = "The desired number of nodes in the EKS node group"
    type        = number
    default     = 2
}
variable "instance_types" {
    description = "The instance types for the EKS node group"
    type        = list(string)
    default     = ["t3.medium"]
}
variable "capacity_type" {
    description = "The capacity type for the EKS node group"
    type        = string
    default     = "ON_DEMAND"
}