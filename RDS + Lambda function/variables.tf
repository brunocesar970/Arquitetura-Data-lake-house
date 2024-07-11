variable "username" {
  type = string
}
variable "password" {
  type = string
}
variable "subnet_ids" {
  type    = list(string)
}
variable "vpc_id" {
  type = string
}

variable "aws_route_table_association_a_subnet_id" {
  type = string  
}

variable "aws_route_table_association_b_subnet_id" {
  type = string
}

variable "subnet_ids_lambda" {
  type    = list(string)
}

variable "security_group_id_lambda" {
  type = list(string)
}