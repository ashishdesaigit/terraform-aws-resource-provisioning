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
    name = "iam_for_lambda_${terraform.workspace}"
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


resource "aws_iam_policy" "dynamo-policy" {
  name        = "dynamo-policy"
  description = "A policy dynamo access"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "dynamodb:*",
      "Effect": "Allow",
      "Resource": [
            "${aws_dynamodb_table.projects-dynamodb-table.arn}",
            "${aws_dynamodb_table.consultants-dynamodb-table.arn}",
            "${aws_dynamodb_table.users-dynamodb-table.arn}"
       ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach-dynamo-access" {
  role       = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = "${aws_iam_policy.dynamo-policy.arn}"
}



data "aws_s3_bucket_object" "foo-lambda" {
  bucket = "foo-artefacts"
  key    = "foo.zip"
}

resource "aws_lambda_function" "foo_function" {

    function_name   = "foo_function-${terraform.workspace}"

    s3_bucket         = "${data.aws_s3_bucket_object.foo-lambda.bucket}"
    s3_key            = "${data.aws_s3_bucket_object.foo-lambda.key}"
    s3_object_version = "${data.aws_s3_bucket_object.foo-lambda.version_id}"

    handler         = "index.handler"
    runtime         = "nodejs12.x"
    role            = aws_iam_role.iam_for_lambda.arn

    environment {
        variables = {
          projects_table_name = "${local.workspace["projects_table_name"]}"
          consultants_table_name = "${local.workspace["consultants_table_name"]}"
          users_table_name = "${local.workspace["users_table_name"]}"
        }
      }

}
