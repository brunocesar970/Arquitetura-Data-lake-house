module "lambda_function_in_vpc" {
  source = "terraform-aws-modules/lambda/aws"
  
  function_name = "populate-mysql"
  description   = "Function that creates and populates tables in mysql RDS"
  handler       = "handler.populate_mysql"
  runtime       = "python3.10"
  timeout       = 900
  memory_size   = 1028  # Define a memória para 1028 MB

  source_path = "functions/insert_into_mysql"

  vpc_subnet_ids         = var.subnet_ids_lambda
  vpc_security_group_ids = var.security_group_id_lambda
  attach_network_policy  = true

    layers = [
    module.lambda_layer.lambda_layer_arn
  ]

    environment_variables = {
        DB_INSTANCE_ADDRESS            = aws_db_instance.default.address
        DB_USERNAME                    = aws_db_instance.default.username
        DB_PASSWORD                    = aws_db_instance.default.password
        DB_PORT                        = 3306
        DB_NAME                        = aws_db_instance.default.db_name
      }
  }

module "lambda_layer" {
  source = "terraform-aws-modules/lambda/aws"

  create_layer = true

  layer_name          = "python-dependencies"
  description         = "Lambda Layer with Python dependencies"
  compatible_runtimes = ["python3.10"]

  source_path = "lambda_layer/python.zip"
}