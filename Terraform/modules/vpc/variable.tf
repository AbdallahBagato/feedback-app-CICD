variable "vpc_cidr" {
    description = "The CIDR block of the vpc"
    type = string
    default = "10.10.0.0/16"
  
}
variable "cluster_name" {
    description = "define your cluster name"
    type = string 
    default = "Eks Cluster"
}

variable "private_subnet_cidr"{
    description = "define your private cidr"
    type = list(string)

}

variable "availability_zones" {
    description = "define your AZ"
    type = list(string)
  
}

variable "public_subnet_cidr" {
    description = "define your public cidr"
    type = list(string)  
}

