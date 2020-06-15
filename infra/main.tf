provider "aws" {
    region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "tfbackend"
    key    = "tfstate"
    region = "us-west-2"
  }
}



resource "aws_iam_role" "iam_for_lambda" {
    name = "iam_for_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_lambda_function" "foo_function" {
    function_name   = "foo_function"
    s3_bucket       = "foo-function-archieve"
    s3_key          = "foo.zip"
    handler         = "index.handler"
    runtime         = "nodejs12.x"
    role            = aws_iam_role.iam_for_lambda.arn

    source_code_hash = filebase64sha256("foo.zip")

}
