# awsconnect-salesforce-iam
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.51.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cloud_watch_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.invoke_execute_aws_service_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.kms_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.secretsmanager_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.vpc_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ctr_trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.execute_aws_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.execute_transcription_state_machine](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.get_transcribe_job_status](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda_basic_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda_basic_exec_s3read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.process_contactlens](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.process_transcription_result](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.realtime_queue_metrics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.realtime_queue_metrics_cron_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.realtime_queue_metrics_loop_job](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.realtime_queue_metrics_loop_job_state_machine](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.sig4_request_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.submit_transcribe_job](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.transcribe_state_machine](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.ctr_trigger_kinesis_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.ctr_trigger_lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_aws_service_connect_audio_recording_cloud_front_key_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_aws_service_connect_audio_recording_cloud_front_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_aws_service_connect_audio_recording_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_aws_service_connect_audio_recording_lambda_invoke_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_aws_service_connect_audio_recording_lambda_replication_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_aws_service_connect_audio_recording_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_aws_service_connect_contact_lens_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_aws_service_connect_guided_setup_instance_kinesis_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_aws_service_connect_guided_setup_instance_kms_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_aws_service_connect_guided_setup_instance_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_aws_service_connect_guided_setup_instance_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_aws_service_service_linked_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_transcription_state_machine_invoke_api_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_transcription_state_machine_lock_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_transcription_state_machine_recording_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execute_transcription_state_machine_step_function_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.get_transcribe_job_status_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.process_contactlens_connect_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.process_contactlens_data_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.process_contactlens_invoke_api_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.process_contactlens_recording_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.process_contactlens_result_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.process_transcription_result_comprehend_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.process_transcription_result_invoke_api_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.process_transcription_result_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.realtime_queue_metrics_connect_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.realtime_queue_metrics_cron_start_step_functions_lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.realtime_queue_metrics_loop_job_invoke_lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.realtime_queue_metrics_loop_job_state_machine_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.s3read_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.sig4_request_to_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.submit_transcribe_job_connect_recording_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.submit_transcribe_job_output_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.submit_transcribe_job_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.transcribe_state_machine_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy.cloud_watch_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.kms_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.secretsmanager_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.vpc_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.events-assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda-assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda-edge-assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.states-assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AmazonConnectInstanceId"></a> [AmazonConnectInstanceId](#input\_AmazonConnectInstanceId) | Enter Amazon Connect Instance Id, the string after the last / in your Amazon Connect instance ARN (aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee). Not required if RealtimeReportingImportEnabled is set to false. | `string` | n/a | yes |
| <a name="input_CTRKinesisARN"></a> [CTRKinesisARN](#input\_CTRKinesisARN) | Enter Kinesis Stream ARN for CTR. Not required if PostcallCTRImportEnabled, PostcallRecordingImportEnabled and PostcallTranscribeEnabled all set to false | `string` | `""` | no |
| <a name="input_ConnectRecordingS3BucketName"></a> [ConnectRecordingS3BucketName](#input\_ConnectRecordingS3BucketName) | This is the S3 bucket where Amazon Connect stores call recordings. Please refer to http://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-instance.html#datastorage for details on how retrieve the S3 bucket associated with your Amazon Connect instance. Not required if both PostcallRecordingImportEnabled and PostcallTranscribeEnabled set to false. | `string` | n/a | yes |
| <a name="input_ConnectReportingS3BucketName"></a> [ConnectReportingS3BucketName](#input\_ConnectReportingS3BucketName) | This is the S3 bucket where Amazon Connect stores scheduled reports. Please refer to http://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-instance.html#datastorage for details on how retrieve the S3 bucket associated with your Amazon Connect instance. Not required if HistoricalReportingImportEnabled set to false. | `string` | n/a | yes |
| <a name="input_ContactLensImportEnabled"></a> [ContactLensImportEnabled](#input\_ContactLensImportEnabled) | Set to false if importing Contact Lens into Salesforce should not be enabled. | `string` | n/a | yes |
| <a name="input_HistoricalReportingImportEnabled"></a> [HistoricalReportingImportEnabled](#input\_HistoricalReportingImportEnabled) | Set to false if importing Historical Reporting into Salesforce should not be enabled. | `string` | n/a | yes |
| <a name="input_PostcallCTRImportEnabled"></a> [PostcallCTRImportEnabled](#input\_PostcallCTRImportEnabled) | Set to false if importing CTRs into Salesforce should not be enabled on the package level. | `string` | n/a | yes |
| <a name="input_PostcallRecordingImportEnabled"></a> [PostcallRecordingImportEnabled](#input\_PostcallRecordingImportEnabled) | Set to false if importing call recordings into Salesforce should not be enabled on the package level. See installation guide for setup details. | `string` | n/a | yes |
| <a name="input_PostcallTranscribeEnabled"></a> [PostcallTranscribeEnabled](#input\_PostcallTranscribeEnabled) | Set to false if post-call transcription should not be enabled on the package level. See installation guide for setup details. | `string` | n/a | yes |
| <a name="input_PrivateVpcEnabled"></a> [PrivateVpcEnabled](#input\_PrivateVpcEnabled) | Set to true if functions should be deployed to a private VPC, set VpcSecurityGroupList and VpcSubnetList if true | `string` | n/a | yes |
| <a name="input_RealtimeReportingImportEnabled"></a> [RealtimeReportingImportEnabled](#input\_RealtimeReportingImportEnabled) | Set to false if importing Realtime Reporting into Salesforce should not be enabled. | `string` | n/a | yes |
| <a name="input_SalesforceCredentialsKMSKeyARN"></a> [SalesforceCredentialsKMSKeyARN](#input\_SalesforceCredentialsKMSKeyARN) | Enter the ARN for the Salesforce Credentials KMS Key. This field is required. | `string` | n/a | yes |
| <a name="input_SalesforceCredentialsSecretsManagerARN"></a> [SalesforceCredentialsSecretsManagerARN](#input\_SalesforceCredentialsSecretsManagerARN) | Enter the ARN for the Salesforce Credentials Secret in AWS Secrets Manager. This field is required. | `string` | n/a | yes |
| <a name="input_TranscribeOutputS3BucketName"></a> [TranscribeOutputS3BucketName](#input\_TranscribeOutputS3BucketName) | This is the S3 bucket where Amazon Transcribe stores the output. If you don't specify an encryption key, the output of the transcription job is encrypted with the default Amazon S3 key (SSE-S3).Not required if both PostcallRecordingImportEnabled and PostcallTranscribeEnabled set to false. | `string` | n/a | yes |

## Outputs

No outputs.