variable "vpc_id" {
  type    = string
}

variable "wordpress_sg_id" {
  type    = string
}
variable "private_subnet_ids" {
  type    = list (string)
}

variable "rds_sg_id" {
  type    = string
}