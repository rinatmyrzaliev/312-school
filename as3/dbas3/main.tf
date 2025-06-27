resource "aws_security_group" "rds_sg" {
    name = "rds-sg"
    description = "security group for db"
    vpc_id = var.vpc_id


ingress { 
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  security_groups = [var.wordpress_sg_id]

}
 
  tags = {
    Name = "rds-sg"
  }

}

resource "aws_db_instance" "mysqldb" {
  identifier           = "mysqldb"
  allocated_storage    = 20
  storage_type         = "gp2"
  db_name              = "mysqldb"
  engine               = "mysql"
  engine_version       = "8.0.35"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "adminadmin"
  db_subnet_group_name = aws_db_subnet_group.dbprivate.name
  vpc_security_group_ids  = [var.rds_sg_id]
  skip_final_snapshot  = true
  publicly_accessible  = false
}

resource "aws_db_subnet_group" "dbprivate" {
  name       = "dbprivate"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "My DB subnet group"
  }
}