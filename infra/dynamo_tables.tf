resource "aws_dynamodb_table" "projects-dynamodb-table" {
  name           = "projects-${terraform.workspace}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "consultants-dynamodb-table" {
  name           = "consultants-${terraform.workspace}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "users-dynamodb-table" {
  name           = "users-${terraform.workspace}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}