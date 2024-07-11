variable "username" {
  type = string
  default = "estudo"
}
variable "password" {
  type = string
  default = "estudo_aws"
}
variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-09c3e62a2b3abf3e8", "subnet-0d44694167afd5bce"]
}
variable "vpc_id" {
  type = string
  default = "vpc-0d1aff2a6f1ea3321"
}

variable "aws_route_table_association_a_subnet_id" {
  type = string
  default = "subnet-09c3e62a2b3abf3e8"
  
}

variable "aws_route_table_association_b_subnet_id" {
  type = string
  default = "subnet-0d44694167afd5bce"
}

variable "subnet_ids_lambda" {
  type    = list(string)
  default = ["subnet-09c3e62a2b3abf3e8","subnet-0d44694167afd5bce","subnet-010f5d7e0daa786ad"]
}

variable "security_group_id_lambda" {
    type = list(string)
    default = "sg-0ac8dc1fd5194606f"
    }