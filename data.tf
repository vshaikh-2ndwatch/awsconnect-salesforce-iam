data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy" "secretsmanager_policy" {
  count = length(aws_iam_policy.vpc_policy)
  arn = aws_iam_policy.secretsmanager_policy[count.index].arn
}

data "aws_iam_policy" "kms_policy" {
  count = length(aws_iam_policy.vpc_policy)
  arn = aws_iam_policy.kms_policy[count.index].arn
}

data "aws_iam_policy" "cloud_watch_policy" {
  arn = aws_iam_policy.cloud_watch_policy.arn
}

data "aws_iam_policy" "vpc_policy" {
  count = length(aws_iam_policy.vpc_policy)
  arn   = aws_iam_policy.vpc_policy[count.index].arn
}

data "aws_iam_policy_document" "lambda-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda-edge-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "states-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["states.${data.aws_region.current.name}.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "events-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}
