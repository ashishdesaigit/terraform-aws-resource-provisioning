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
    name = "iam_for_lambda",
    assume_role_polict = <<EOF
        {
            "Version" : "2017-10-17",
            "Statement" : [
            {
                "Action" : "sts:AssumeRole",
                "Principle" : {
                    "Service" : "lambda.amazonaws.com"
                },
                "Effect" : "Allow",
                "Sid" : ""
            }
            ]
        }
    EOF
}

resource "aws_lambda_function" "foo_function" {
    function_name   = "foo_function"
    s3_bucket       = "foo_function_archieve"
    s3_key          = "foo_function.zip"
    handler         = "index.handler"
    runtime         = "nodejs12.x"
    role            = "${aws_iam_role.iam_for_lambda.arn}"
}
