#IAM Policies

# ToDo: invokeSfExecuteAWSServicePolicy - dependency on lambda - sfExecuteAWSService.Arn

resource "aws_iam_policy" "invoke_execute_aws_service_policy" {
  name        = "invokeSfExecuteAWSServicePolicy"
  path        = "/"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "lambda:InvokeFunction"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${local.execute_aws_service_function_name}"
      },
    ]
  })
}

resource "aws_iam_policy" "secretsmanager_policy" {
  count = local.SalesforceCredentialsSecretsManagerARNHasValue ? 1 : 0
  name        = "SecretsManagerManagedPolicy"
  path        = "/"
  description = "IAM Policy for Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:PutSecretValue",
        ]
        Effect   = "Allow"
        Resource = var.SalesforceCredentialsSecretsManagerARN
      },
    ]
  })
}

resource "aws_iam_policy" "kms_policy" {
  count = local.SalesforceCredentialsKMSKeyARNHasValue ? 1 : 0
  name        = "KMSManagedPolicy"
  path        = "/"
  description = "IAM Policy for KMS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "kms:decrypt",
          "kms:generatedatakey",
        ]
        Effect   = "Allow"
        Resource = var.SalesforceCredentialsKMSKeyARN
      },
    ]
  })
}

resource "aws_iam_policy" "cloud_watch_policy" {
  name        = "CloudWatchManagedPolicy"
  path        = "/"
  description = "IAM Policy for Cloud Watch"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:PutLogEvents",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      },
    ]
  })
}

resource "aws_iam_policy" "vpc_policy" {
  count       = local.PrivateVpcEnabledCondition ? 1 : 0
  name        = "VpcManagedPolicy"
  path        = "/"
  description = "IAM Policy for VPC"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}