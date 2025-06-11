resource "aws_instance" "myec2" {
    instance_type = var.instance_type
    ami  = var.ami
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.vpc_security_group_id]

tags = {
  Name = "practice2"
}
}
