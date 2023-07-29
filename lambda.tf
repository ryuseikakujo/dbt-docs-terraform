data "archive_file" "function_source" {
  type        = "zip"
  source_dir  = "lambda_edge"
  output_path = "lambda_edge_archive/function.zip"
}


resource "aws_lambda_function" "cloudfront_auth" {
  provider         = aws.virginia
  function_name    = "${var.env}-${var.app_name}-dbt-docs-auth"
  handler          = "index.handler"
  role             = aws_iam_role.lambda.arn
  runtime          = "python3.8"
  publish          = true
  filename         = data.archive_file.function_source.output_path
  source_code_hash = data.archive_file.function_source.output_base64sha256

  depends_on = [
    aws_iam_role_policy_attachment.lambda,
  ]

  lifecycle {
    ignore_changes = [
      source_code_hash
    ]
  }
}
