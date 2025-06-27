
variable "ingress_ports" {
  description = "List of ingress ports to allow from the Internet"
  type        = list(number)
}

variable "ami_id" {
  type    = string
}

variable "public_subnet_id" {
  type    = string
}

variable "wordpress_sg_id" {
  type    = string
}

variable "vpc_id" {
  type    = string
}

variable "private_subnet_ids" {
  type    = list (string)
}

variable "rds_sg_id" {
  type    = string
}