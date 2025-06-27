module "ec2" {
    source = "../ec2"
    instance_type = "t2.micro"
    ami = "ami-0779caf41f9ba54f0"
    subnet_id = "subnet-0bcfb5855b5d7bd00"
    vpc_security_group_id = module.sg.sg_id

}

module "sg" {
    source = "../sg"
    sg_name = "Allow https"
    vpc_id = "vpc-0d39dfa5a97f49404"
    port = 443

}