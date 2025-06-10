# 1. Public Key
resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIhJzS49+wJI/r+FfJyh0MG3XT6C51XoEziY99G1smSTaV95LmAsOQdzb0LVM0ZoM+IoGyMiXU60XcZb8fh6ji6l2QhiuZUlvU7T7H8OTVtVqS/bVA3vSxla3a6+zstWffU3NtiT3RSBH+X7oHmxCP/ytTfYPeiXTkg8aDqYAJ1WUOHxnkA3c0NNurlzgcR0NLUWNly9a7YkNHiGg1R9/p8rBl3qUsw0zpGTdtNmNERDJDBYtLUWWa7iRv+CoouGCUJXOa5IRaYygHeRE1FbtLELGoOquOwriq5qVPmZYWCcdywVCwhf2EBTTIzWL+WvFVMsdZuvnt36BEH3PVOM/6xghLOPa5a1ahddv9dlyhENmj6eNCDO20SFCQ1+Ddk8vXflCOTId06DEfg51xoyeYUTo81WONR8pRralU+oKGHdva7K1EFADHRLOLOXsCpk0ADrJR1f7RJyWgFcmcZMYePLFWN309gTOMYuK/H2lWP3zR289RK4OwvRDDhQIwJuM= rinatsabira@Sabiras-MacBook-Air.local"  
}

# 2. EC2

resource "aws_instance" "wordpress_ec2" {
  ami                    = var.ami_id          
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_id    
  vpc_security_group_ids = [var.wordpress_sg_id]   
  key_name               = aws_key_pair.ssh_key.key_name
  associate_public_ip_address = true

    user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras enable php8.0
              yum install -y php php-mysqlnd httpd mariadb wget unzip

              systemctl start httpd
              systemctl enable httpd

              cd /var/www/html
              wget https://wordpress.org/latest.zip
              unzip latest.zip
              mv wordpress blog
              chown -R apache:apache blog
              chmod -R 755 blog

              systemctl restart httpd
              EOF


  tags = {
    Name = "wordpress-ec2"
  }
}
