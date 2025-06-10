module vpc {
  source     = "./vpcas3"
  ingress_ports = var.ingress_ports
}

module ec2 {
  source     = "./ec2as3"
  ami_id = "ami-0dc3a08bd93f84a35"
  public_subnet_id = var.public_subnet_id
  wordpress_sg_id = var.wordpress_sg_id

}

module db {
  source     = "./dbas3"
  vpc_id = var.vpc_id
  wordpress_sg_id = var.wordpress_sg_id
  private_subnet_ids = var.private_subnet_ids
  rds_sg_id = var.rds_sg_id
}