#Basic Excecution Role
resource "aws_iam_role" "lambda_basic_exec" {
  name                = "sfLambdaBasicExec"
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.lambda-assume-role-policy.json
  managed_policy_arns = local.Managed_Policies_Based_on_Conditions
}

#Basic Execution with S3 Read Policy Role
resource "aws_iam_role_policy" "s3read_policy" {
  count = local.HistoricalReportingImportEnabledCondition ? 1 : 0

  name = "sfLambdaBasicExecWithS3ReadReportingS3Policy"
  role = aws_iam_role.lambda_basic_exec_s3read.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject"]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.ConnectReportingS3BucketName}/*"
      },
    ]
  })
}

resource "aws_iam_role" "lambda_basic_exec_s3read" {
  name                = "sfLambdaBasicExecWithS3Read"
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.lambda-assume-role-policy.json
  managed_policy_arns = local.Managed_Policies_Based_on_Conditions
}

# RealTime Queue Metrics Role
resource "aws_iam_role_policy" "realtime_queue_metrics_connect_policy" {
  count = local.sfRealTimeQueueMetricsConnectPolicyCondition ? 1 : 0

  name = "sfRealTimeQueueMetricsConnectPolicy"
  role = aws_iam_role.realtime_queue_metrics.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["connect:ListQueues",
        "connect:GetCurrentMetricData"]
        Effect   = "Allow"
        Resource = "arn:aws:connect:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/${var.AmazonConnectInstanceId}/*"
      },
    ]
  })
}

resource "aws_iam_role" "realtime_queue_metrics" {
  name                = "sfRealTimeQueueMetricsRole"
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.lambda-assume-role-policy.json
  managed_policy_arns = local.Managed_Policies_Based_on_Conditions
}

# Get Transcribe Job Status Role
resource "aws_iam_role_policy" "get_transcribe_job_status_policy" {
  name = "sfGetTranscribeJobStatusTranscribePolicy"
  role = aws_iam_role.get_transcribe_job_status.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["transcribe:GetTranscriptionJob"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "get_transcribe_job_status" {
  name                = "sfGetTranscribeJobStatusRole"
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.lambda-assume-role-policy.json
  managed_policy_arns = [data.aws_iam_policy.cloud_watch_policy.arn]
}

# Submit Transcribe Job Status Role
resource "aws_iam_role_policy" "submit_transcribe_job_policy" {

  name = "sfSubmitTranscribeJobTranscribePolicy"
  role = aws_iam_role.submit_transcribe_job.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["transcribe:StartTranscriptionJob"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "submit_transcribe_job_connect_recording_s3_policy" {
  count = local.sfSubmitTranscribeJobConnectRecordingS3PolicyCondition ? 1 : 0

  name = "sfSubmitTranscribeJobConnectRecordingS3Policy"
  role = aws_iam_role.submit_transcribe_job.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:GetObjectAcl"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.ConnectRecordingS3BucketName}/*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "submit_transcribe_job_output_s3_policy" {
  count = local.sfSubmitTranscribeJobTranscribeOutputS3PolicyCondition ? 1 : 0

  name = "sfSubmitTranscribeJobTranscribeOutputS3Policy"
  role = aws_iam_role.submit_transcribe_job.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.TranscribeOutputS3BucketName}/*"
      },
    ]
  })
}

resource "aws_iam_role" "submit_transcribe_job" {
  name                = "sfSubmitTranscribeJobRole"
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.lambda-assume-role-policy.json
  managed_policy_arns = [data.aws_iam_policy.cloud_watch_policy.arn]
}

# Signature Ver4 Request to S3 Role
resource "aws_iam_role_policy" "sig4_request_to_s3_policy" {
  count = local.ConnectRecordingS3BucketNameHasValue ? 1 : 0
  name = "sfSig4RequestToS3RolePolicy"
  role = aws_iam_role.sig4_request_to_s3[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject"]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.ConnectRecordingS3BucketName}/*"
      },
    ]
  })
}

resource "aws_iam_role" "sig4_request_to_s3" {
  count = local.PostcallRecordingImportEnabledCondition ? 1 : 0
  name                = "sfSig4RequestToS3Role"
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.lambda-edge-assume-role-policy.json
  managed_policy_arns = [data.aws_iam_policy.cloud_watch_policy.arn]
}

# RealTime Queue metrics Loop Job Role
resource "aws_iam_role_policy" "realtime_queue_metrics_loop_job_invoke_lambda_policy" {
  name = "sfRealTimeQueueMetricsLoopJobInvokeLambdaPolicy"
  role = aws_iam_role.realtime_queue_metrics_loop_job.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["lambda:InvokeFunction"]
        Effect   = "Allow"
        Resource = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${local.realtime_queue_metrics_lambda_function_name}"
      },
    ]
  })
}

resource "aws_iam_role" "realtime_queue_metrics_loop_job" {
  name                = "sfRealTimeQueueMetricsLoopJobRole"
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.lambda-assume-role-policy.json
  managed_policy_arns = [data.aws_iam_policy.cloud_watch_policy.arn]
}

# Process Transcription Result Role
resource "aws_iam_role_policy" "process_transcription_result_s3_policy" {
  count = local.sfProcessTranscriptionResultS3PolicyCondition ? 1 : 0

  name = "sfProcessTranscriptionResultS3Policy"
  role = aws_iam_role.process_transcription_result.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["s3:GetObject", "s3:PutObject"]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.TranscribeOutputS3BucketName}/*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "process_transcription_result_comprehend_policy" {
  name = "sfProcessTranscriptionResultComprehendPolicy"
  role = aws_iam_role.process_transcription_result.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "comprehend:Detect*",
          "comprehend:BatchDetect*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "process_transcription_result_invoke_api_policy" {
  name = "sfProcessTranscriptionResultSfInvokeAPIPolicy"
  role = aws_iam_role.process_transcription_result.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "lambda:InvokeFunction"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${local.invoke_api_lambda_function_name}"
      },
    ]
  })
}

resource "aws_iam_role" "process_transcription_result" {
  name                = "sfProcessTranscriptionResultRole"
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.lambda-assume-role-policy.json
  managed_policy_arns = [data.aws_iam_policy.cloud_watch_policy.arn]
}

# Process Contact Lens Role
resource "aws_iam_role_policy" "process_contactlens_result_s3_policy" {
  count = local.sfProcessContactLensResultS3PolicyCondition ? 1 : 0

  name = "sfProcessContactLensResultS3Policy"
  role = aws_iam_role.process_contactlens.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.TranscribeOutputS3BucketName}/*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "process_contactlens_recording_s3_policy" {
  count = local.sfProcessContactLensRecordingS3PolicyCondition ? 1 : 0

  name = "sfProcessContactLensRecordingS3Policy"
  role = aws_iam_role.process_contactlens.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.ConnectRecordingS3BucketName}/connect/${var.AmazonConnectInstanceId}/CallRecordings/*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "process_contactlens_data_s3_policy" {
  count = local.sfProcessContactLensDataS3PolicyCondition ? 1 : 0

  name = "sfProcessContactLensDataS3Policy"
  role = aws_iam_role.process_contactlens.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${var.ConnectRecordingS3BucketName}/*",
          "arn:aws:s3:::${var.ConnectRecordingS3BucketName}"
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy" "process_contactlens_connect_policy" {
  count = local.sfProcessContactLensConnectPolicyCondition ? 1 : 0

  name = "sfProcessContactLensConnectPolicy"
  role = aws_iam_role.process_contactlens.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "connect:GetContactAttributes"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:connect:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/${var.AmazonConnectInstanceId}/contact/*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "process_contactlens_invoke_api_policy" {
  name = "sfProcessContactLensSfInvokeAPIPolicy"
  role = aws_iam_role.process_contactlens.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "lambda:InvokeFunction"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${local.invoke_api_lambda_function_name}"
      },
    ]
  })
}

resource "aws_iam_role" "process_contactlens" {
  name                = "sfProcessContactLensRole"
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.lambda-assume-role-policy.json
  managed_policy_arns = [data.aws_iam_policy.cloud_watch_policy.arn]
}

# Transcribe State Machine Role
resource "aws_iam_role_policy" "transcribe_state_machine_policy" {
  name = "sfTranscribeStateMachinePolicy"
  role = aws_iam_role.transcribe_state_machine.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["lambda:InvokeFunction"]
        Effect   = "Allow"
        Resource = [
                    "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${local.submit_transcibe_job_lambda_function_name}",
                    "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${local.get_transcibe_job_status_lambda_function_name}",
                    "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${local.process_transcription_result_lambda_function_name}"
                    ]
      },
    ]
  })
}

resource "aws_iam_role" "transcribe_state_machine" {
  name               = "sfTranscribeStateMachineRole"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.states-assume-role-policy.json
}

# Realtime Queue Metrics Loop Job State Machine Role
resource "aws_iam_role_policy" "realtime_queue_metrics_loop_job_state_machine_policy" {
  name = "sfRealTimeQueueMetricsLoopJobStateMachinePolicy"
  role = aws_iam_role.realtime_queue_metrics_loop_job_state_machine.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["lambda:InvokeFunction"]
        Effect   = "Allow"
        Resource = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${local.realtime_queue_metrics_loop_job_lambda_function_name}"
      },
    ]
  })
}

resource "aws_iam_role" "realtime_queue_metrics_loop_job_state_machine" {
  name               = "sfRealTimeQueueMetricsLoopJobStateMachineRole"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.states-assume-role-policy.json
}

# Execute Transcription State Machine Role
resource "aws_iam_role_policy" "execute_transcription_state_machine_step_function_policy" {
  name = "sfExecuteTranscriptionStateMachineStepFunctionPolicy"
  role = aws_iam_role.execute_transcription_state_machine.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["states:StartExecution","states:StopExecution"]
        Effect   = "Allow"
        Resource = "arn:aws:states:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stateMachine:${local.transcribe_state_machine_name}"
      },
    ]
  })
}

resource "aws_iam_role_policy" "execute_transcription_state_machine_lock_s3_policy" {
  count = local.sfExecuteTranscriptionStateMachineLockS3PolicyCondition ? 1 :0
  name = "sfExecuteTranscriptionStateMachineLockS3Policy"
  role = aws_iam_role.execute_transcription_state_machine.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject","s3:PutObject","s3:ListBucket"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::${var.TranscribeOutputS3BucketName}" ,"arn:aws:s3:::${var.TranscribeOutputS3BucketName}/*"]
      },
    ]
  })
}

resource "aws_iam_role_policy" "execute_transcription_state_machine_recording_s3_policy" {
  count = local.sfExecuteTranscriptionStateMachineRecordingS3PolicyCondition ? 1 :0
  name = "sfExecuteTranscriptionStateMachineRecordingS3Policy"
  role = aws_iam_role.execute_transcription_state_machine.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject"]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.ConnectRecordingS3BucketName}/*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "execute_transcription_state_machine_invoke_api_policy" {
  name = "sfExecuteTranscriptionStateMachineSfInvokeAPIPolicy"
  role = aws_iam_role.execute_transcription_state_machine.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["lambda:InvokeFunction"]
        Effect   = "Allow"
        Resource = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${local.invoke_api_lambda_function_name}"
      },
    ]
  })
}

resource "aws_iam_role" "execute_transcription_state_machine" {
  name               = "sfExecuteTranscriptionStateMachineRole"
  path               = "/"
  assume_role_policy  = data.aws_iam_policy_document.lambda-assume-role-policy.json
  managed_policy_arns = [data.aws_iam_policy.cloud_watch_policy.arn]
}

# CTR Trigger Role
resource "aws_iam_role_policy" "ctr_trigger_kinesis_policy" {
  count = local.CTREventSourceMappingCondition ? 1 : 0
  name = "sfCTRTriggerKinesisPolicy"
  role = aws_iam_role.ctr_trigger.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["kinesis:GetShardIterator","kinesis:GetRecords","kinesis:DescribeStream"]
        Effect   = "Allow"
        Resource = "${var.CTRKinesisARN}"
      },
    ]
  })
}

resource "aws_iam_role_policy" "ctr_trigger_lambda_policy" {
  name = "sfCTRTriggerLambdaPolicy"
  role = aws_iam_role.ctr_trigger.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["lambda:InvokeFunction","lambda:InvokeAsync"]
        Effect   = "Allow"
        Resource = [
             "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${local.execute_transcription_state_machine_lambda_function_name}",
             "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${local.contacttrace_record_lambda_function_name}"
          ]
      },
    ]
  })
}

resource "aws_iam_role" "ctr_trigger" {
  name               = "sfCTRTriggerRole"
  path               = "/"
  assume_role_policy  = data.aws_iam_policy_document.lambda-assume-role-policy.json
  managed_policy_arns = [data.aws_iam_policy.cloud_watch_policy.arn]
}



#RealTime Queue Metrics Cron Execution
resource "aws_iam_role_policy" "realtime_queue_metrics_cron_start_step_functions_lambda_policy" {
  name = "sfRealTimeQueueMetricsCronStartStepFunctions"
  role = aws_iam_role.realtime_queue_metrics_cron_execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["states:StartExecution"]
        Effect   = "Allow"
        Resource = "arn:aws:states:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stateMachine:${local.realtime_queue_metrics_loop_job_state_machine_name}"
      },
    ]
  })                                                         
}

resource "aws_iam_role" "realtime_queue_metrics_cron_execution" {
  name               = "sfRealTimeQueueMetricsCronExecutionRole"
  path               = "/service-role/"
  assume_role_policy  = data.aws_iam_policy_document.events-assume-role-policy.json
}

#Execute AWS Service
resource "aws_iam_role_policy" "execute_aws_service_connect_contact_lens_policy" {
  count = local.AmazonConnectInstanceIdHasValue ? 1 : 0
  name = "sfExecuteAWSServiceConnectContactLensPolicy"
  role = aws_iam_role.execute_aws_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["connect:ResumeContactRecording",
                    "connect:UpdateContactAttributes",
                    "connect:StartContactRecording",
                    "connect:SuspendContactRecording",
                    "connect:StopContactRecording"]
        Effect   = "Allow"
        Resource = "arn:aws:connect:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/${var.AmazonConnectInstanceId}/*"
      },
    ]
  })                                                         
}

resource "aws_iam_role_policy" "execute_aws_service_connect_guided_setup_instance_policy" {
  name = "sfExecuteAWSServiceConnectGuidedSetupInstancePolicy"
  role = aws_iam_role.execute_aws_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["connect:CreateInstance",
                    "connect:ListInstances",
                    "connect:AssociateApprovedOrigin",
                    "connect:AssociateInstanceStorageConfig",
                    "connect:ListInstanceStorageConfigs",
                    "connect:UpdateInstanceStorageConfig",
                    "ds:DescribeDirectories",
                    "ds:AuthorizeApplication",
                    "ds:CheckAlias",
                    "ds:CreateAlias",
                    "ds:CreateIdentityPoolDirectory",
                    "ds:DeleteDirectory",
                    "ds:UnauthorizeApplication"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })                                                         
}

resource "aws_iam_role_policy" "execute_aws_service_connect_guided_setup_instance_kms_policy" {
  name = "sfExecuteAWSServiceConnectGuidedSetupInstancePolicyKMS"
  role = aws_iam_role.execute_aws_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["kms:CreateGrant",
                    "kms:DescribeKey"]
        Effect   = "Allow"
        Resource = "arn:aws:kms:*:${data.aws_caller_identity.current.account_id}:key/*"
      },
    ]
  })                                                         
}

resource "aws_iam_role_policy" "execute_aws_service_connect_guided_setup_instance_s3_policy" {
  name = "sfExecuteAWSServiceConnectGuidedSetupInstancePolicyS3"
  role = aws_iam_role.execute_aws_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetBucketLocation",
                    "s3:GetBucketAcl",
                    "s3:CreateBucket"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })                                                         
}

resource "aws_iam_role_policy" "execute_aws_service_connect_guided_setup_instance_kinesis_policy" {
  name = "sfExecuteAWSServiceConnectGuidedSetupInstancePolicyKinesis"
  role = aws_iam_role.execute_aws_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["kinesis:CreateStream",
                    "kinesis:DescribeStream"]
        Effect   = "Allow"
        Resource = "arn:aws:kinesis:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stream/*"
      },
    ]
  })                                                         
}

resource "aws_iam_role_policy" "execute_aws_service_service_linked_role_policy" {
  name = "sfExecuteAWSServiceServiceLinkedRolePolicy"
  role = aws_iam_role.execute_aws_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["iam:PutRolePolicy",
                    "iam:CreateServiceLinkedRole"]
        Effect   = "Allow"
        Resource = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/connect.amazonaws.com/*"
      },
    ]
  })                                                         
}

resource "aws_iam_role_policy" "execute_aws_service_connect_audio_recording_cloud_front_policy" {
  count = local.sfAudioRecordingStreamingCloudFrontDistributionCondition ? 1 : 0
  name = "sfExecuteAWSServiceConnectAudioRecordingPolicyCloudfront"
  role = aws_iam_role.execute_aws_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["cloudfront:GetDistributionConfig",
                    "cloudfront:UpdateDistribution"]
        Effect   = "Allow"
        Resource = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/*" #Need to check how to get exact name
      },
    ]
  })                                                         
}

resource "aws_iam_role_policy" "execute_aws_service_connect_audio_recording_iam_policy" {
  count = local.sfAudioRecordingStreamingCloudFrontDistributionCondition ? 1 : 0
  name = "sfExecuteAWSServiceConnectAudioRecordingPolicyIAM"
  role = aws_iam_role.execute_aws_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["iam:PassRole"]
        Effect   = "Allow"
        Resource = aws_iam_role.sig4_request_to_s3[count.index].arn
      },
    ]
  })                                                         
}

resource "aws_iam_role_policy" "execute_aws_service_connect_audio_recording_cloud_front_key_policy" {
  count = local.sfAudioRecordingStreamingCloudFrontDistributionCondition ? 1 : 0
  name = "sfExecuteAWSServiceConnectAudioRecordingPolicyCloudfrontKey"
  role = aws_iam_role.execute_aws_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["cloudfront:CreatePublicKey",
                    "cloudfront:CreateKeyGroup"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })                                                         
}

resource "aws_iam_role_policy" "execute_aws_service_connect_audio_recording_lambda_replication_policy" {
  count = local.sfAudioRecordingStreamingCloudFrontDistributionCondition ? 1 : 0
  name = "sfExecuteAWSServiceConnectAudioRecordingPolicyLambdaReplication"
  role = aws_iam_role.execute_aws_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["lambda:EnableReplication",
                    "lambda:PublishVersion",
                    "lambda:CreateFunction",
                    "lambda:GetFunction"]
        Effect   = "Allow"
        Resource = "arn:aws:lambda:us-east-1:${data.aws_caller_identity.current.account_id}:function:*-sfSig4RequestToS3*"
      },
    ]
  })                                                         
}

resource "aws_iam_role_policy" "execute_aws_service_connect_audio_recording_lambda_invoke_policy" {
  count = local.sfAudioRecordingStreamingCloudFrontDistributionCondition ? 1 : 0
  name = "sfExecuteAWSServiceConnectAudioRecordingPolicyLambdaInvoke"
  role = aws_iam_role.execute_aws_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["lambda:InvokeFunction"]
        Effect   = "Allow"
        Resource = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${local.generate_audio_recording_streaming_url_lambda_function_name}"
      },
    ]
  })                                                         
}

resource "aws_iam_role_policy" "execute_aws_service_connect_audio_recording_s3_policy" {
  count = local.sfAudioRecordingStreamingCloudFrontDistributionCondition ? 1 : 0
  name = "sfExecuteAWSServiceConnectAudioRecordingPolicyS3"
  role = aws_iam_role.execute_aws_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetBucketCors",
                    "s3:PutBucketCors"]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.ConnectRecordingS3BucketName}"
      },
    ]
  })                                                         
}

resource "aws_iam_role" "execute_aws_service" {
  name               = "sfExecuteAWSServiceRole"
  path               = "/"
  assume_role_policy  = data.aws_iam_policy_document.lambda-assume-role-policy.json
  managed_policy_arns = [data.aws_iam_policy.cloud_watch_policy.arn]
}


