resource "aws_db_instance" "default" {
  allocated_storage    = 20
  db_name              = "mydb_bruno"
  engine               = "mysql"
  identifier           = "bruno-rds"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.username
  password             = var.password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = true
  db_subnet_group_name = aws_db_subnet_group.meu_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  depends_on = [aws_internet_gateway.igw]
}

output "db_instance_endpoint" {
  value = aws_db_instance.default.endpoint
}

resource "aws_db_subnet_group" "meu_db_subnet_group" {
  name       = "meu-db-subnet-group-mysql"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "Meu DB Subnet Group"
  }
}

resource "aws_security_group" "allow_all" {
  name        = "rds-security-group"
  vpc_id      = var.vpc_id
  description = "Permitir acesso ao RDS"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_mysql" {
  name        = "lambda-security-group"
  vpc_id      = var.vpc_id
  description = "Permitir acesso da Lambda ao MySQL"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "my-internet-gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = var.aws_route_table_association_a_subnet_id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "b" {
  subnet_id      =var.aws_route_table_association_b_subnet_id
  route_table_id = aws_route_table.public.id
}
