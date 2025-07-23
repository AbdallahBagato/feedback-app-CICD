module "vpc" {
    source = "./modules/vpc"
    cluster_name = var.cluster_name
    vpc_cidr = var.vpc_cidr
    public_subnet_cidr = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
    availability_zones = var.availability_zones
}
module "eks" {
    source = "./modules/eks"
    cluster_name = var.cluster_name
    admin_acess = var.admin_acess
    cluster_version = var.cluster_version
    private_subnet_ids = module.vpc.private_subnet_ids
    public_subnet_ids = module.vpc.public_subnet_ids
    max_size = var.max_size
    min_size = var.min_size
    desired_size = var.desired_size
    instance_types = var.instance_types
    capacity_type = var.capacity_type
}