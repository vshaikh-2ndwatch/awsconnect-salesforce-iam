terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.50.0"
    }
  }
}

#local variables
locals {

  #Define Conditions
  PostcallRecordingImportEnabledCondition = (var.PostcallRecordingImportEnabled == "True") || (var.PostcallRecordingImportEnabled == "true")
  PostcallTranscribeEnabledCondition      = (var.PostcallTranscribeEnabled == "True") || (var.PostcallTranscribeEnabled == "true")
  PostcallCTRImportEnabledCondition       = (var.PostcallCTRImportEnabled == "True") || (var.PostcallCTRImportEnabled == "true")

  HistoricalReportingImportEnabledCondition = (var.HistoricalReportingImportEnabled == "True") || (var.HistoricalReportingImportEnabled == "true")
  RealtimeReportingImportEnabledCondition   = (var.RealtimeReportingImportEnabled == "True") || (var.RealtimeReportingImportEnabled == "true")
  ContactLensImportEnabledCondition         = (var.ContactLensImportEnabled == "True") || (var.ContactLensImportEnabled == "true")
  PrivateVpcEnabledCondition                = (var.PrivateVpcEnabled == "True") || (var.PrivateVpcEnabled == "true")

  ConnectReportingS3BucketNameHasValue = (var.ConnectReportingS3BucketName != "")
  ConnectRecordingS3BucketNameHasValue = (var.ConnectRecordingS3BucketName != "")
  TranscribeOutputS3BucketNameHasValue = (var.TranscribeOutputS3BucketName != "")

  SalesforceCredentialsSecretsManagerARNHasValue = (var.SalesforceCredentialsSecretsManagerARN != "")
  SalesforceCredentialsKMSKeyARNHasValue = (var.SalesforceCredentialsKMSKeyARN != "")
  CTRKinesisARNHasValue = (var.CTRKinesisARN != "")
  AmazonConnectInstanceIdHasValue = (var.AmazonConnectInstanceId != "")

  CTREventSourceMappingCondition = (local.CTRKinesisARNHasValue) && (local.PostcallRecordingImportEnabledCondition 
                                        || local.PostcallTranscribeEnabledCondition || local.PostcallCTRImportEnabledCondition)

  sfSubmitTranscribeJobConnectRecordingS3PolicyCondition = local.PostcallTranscribeEnabledCondition && local.ConnectRecordingS3BucketNameHasValue
  sfSubmitTranscribeJobTranscribeOutputS3PolicyCondition = local.PostcallTranscribeEnabledCondition && local.TranscribeOutputS3BucketNameHasValue
  sfExecuteTranscriptionStateMachineRecordingS3PolicyCondition = local.PostcallRecordingImportEnabledCondition && local.ConnectRecordingS3BucketNameHasValue
  sfProcessContactLensRecordingS3PolicyCondition = local.ContactLensImportEnabledCondition && local.ConnectRecordingS3BucketNameHasValue && local.AmazonConnectInstanceIdHasValue
  sfProcessContactLensDataS3PolicyCondition = local.ContactLensImportEnabledCondition && local.ConnectRecordingS3BucketNameHasValue
  sfAudioRecordingStreamingCloudFrontDistributionCondition = local.PostcallRecordingImportEnabledCondition && local.ConnectRecordingS3BucketNameHasValue
  sfExecuteTranscriptionStateMachineLockS3PolicyCondition = (local.PostcallRecordingImportEnabledCondition || local.PostcallTranscribeEnabledCondition) && local.TranscribeOutputS3BucketNameHasValue
  sfProcessTranscriptionResultS3PolicyCondition = local.PostcallTranscribeEnabledCondition && local.TranscribeOutputS3BucketNameHasValue
  sfProcessContactLensResultS3PolicyCondition = local.ContactLensImportEnabledCondition && local.TranscribeOutputS3BucketNameHasValue
  sfRealTimeQueueMetricsConnectPolicyCondition = local.RealtimeReportingImportEnabledCondition && local.AmazonConnectInstanceIdHasValue
  sfProcessContactLensConnectPolicyCondition = local.ContactLensImportEnabledCondition && local.AmazonConnectInstanceIdHasValue

  Managed_Policies_Based_on_Conditions ="${concat(
                        concat([""],(local.SalesforceCredentialsSecretsManagerARNHasValue ? [data.aws_iam_policy.secretsmanager_policy[0].arn] :[""])),
                        concat([""],(local.SalesforceCredentialsKMSKeyARNHasValue ? [data.aws_iam_policy.kms_policy[0].arn] :[""])),
                        concat([""],(local.PrivateVpcEnabledCondition ? [data.aws_iam_policy.vpc_policy[0].arn] :[""])),
                        [data.aws_iam_policy.cloud_watch_policy.arn])}"

  Managed_Policies_VPC_CloudWatch_Only ="${concat(
                        concat([""],(local.PrivateVpcEnabledCondition ? [data.aws_iam_policy.vpc_policy[0].arn] :[""])),
                        [data.aws_iam_policy.cloud_watch_policy.arn])}"

  #Hardcoded values 
  realtime_queue_metrics_lambda_function_name = "sfRealTimeQueueMetrics"
  invoke_api_lambda_function_name = "sfInvokeAPI"
  submit_transcibe_job_lambda_function_name = "sfSubmitTranscribeJob"
  get_transcibe_job_status_lambda_function_name = "sfGetTranscribeJobStatus"
  process_transcription_result_lambda_function_name = "sfProcessTranscriptionResult"
  realtime_queue_metrics_loop_job_lambda_function_name = "sfRealTimeQueueMetricsLoopJob"
  execute_transcription_state_machine_lambda_function_name = "sfExecuteTranscriptionStateMachine"
  contacttrace_record_lambda_function_name = "sfContactTraceRecord"
  execute_aws_service_function_name = "sfExecuteAWSService"
  generate_audio_recording_streaming_url_lambda_function_name="sfGenerateAudioRecordingStreamingURL"

  transcribe_state_machine_name = "sfTranscribeStateMachine"
  realtime_queue_metrics_loop_job_state_machine_name = "sfRealTimeQueueMetricsLoopJobStateMachine"
}