#Salesforce related variables
variable "SalesforceCredentialsSecretsManagerARN" {
  type        = string
  description = "Enter the ARN for the Salesforce Credentials Secret in AWS Secrets Manager. This field is required."
}

variable "SalesforceCredentialsKMSKeyARN" {
  type        = string
  description = "Enter the ARN for the Salesforce Credentials KMS Key. This field is required."
}

#Amazon Connect related variables
variable "AmazonConnectInstanceId" {
  type        = string
  description = "Enter Amazon Connect Instance Id, the string after the last / in your Amazon Connect instance ARN (aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee). Not required if RealtimeReportingImportEnabled is set to false."
}

# Other variables
variable "ConnectReportingS3BucketName" {
  type        = string
  description = "This is the S3 bucket where Amazon Connect stores scheduled reports. Please refer to http://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-instance.html#datastorage for details on how retrieve the S3 bucket associated with your Amazon Connect instance. Not required if HistoricalReportingImportEnabled set to false."
}

variable "ConnectRecordingS3BucketName" {
  type        = string
  description = "This is the S3 bucket where Amazon Connect stores call recordings. Please refer to http://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-instance.html#datastorage for details on how retrieve the S3 bucket associated with your Amazon Connect instance. Not required if both PostcallRecordingImportEnabled and PostcallTranscribeEnabled set to false."
}

variable "TranscribeOutputS3BucketName" {
  type        = string
  description = "This is the S3 bucket where Amazon Transcribe stores the output. If you don't specify an encryption key, the output of the transcription job is encrypted with the default Amazon S3 key (SSE-S3).Not required if both PostcallRecordingImportEnabled and PostcallTranscribeEnabled set to false."
}

variable "CTRKinesisARN" {
  type        = string
  description = "Enter Kinesis Stream ARN for CTR. Not required if PostcallCTRImportEnabled, PostcallRecordingImportEnabled and PostcallTranscribeEnabled all set to false"
  default     = ""
}

variable "PostcallRecordingImportEnabled" {
  type        = string
  description = "Set to false if importing call recordings into Salesforce should not be enabled on the package level. See installation guide for setup details."

  validation {
    condition     = can(regex("^([Tt]rue|[Ff]alse)$", var.PostcallRecordingImportEnabled))
    error_message = "The PostcallRecordingImportEnabled must be True(true) or False(false)."
  }
}

variable "PostcallTranscribeEnabled" {
  type        = string
  description = "Set to false if post-call transcription should not be enabled on the package level. See installation guide for setup details."

  validation {
    condition     = can(regex("^([Tt]rue|[Ff]alse)$", var.PostcallTranscribeEnabled))
    error_message = "The PostcallTranscribeEnabled must be True(true) or False(false)."
  }
}

variable "PostcallCTRImportEnabled" {
  type        = string
  description = "Set to false if importing CTRs into Salesforce should not be enabled on the package level."

  validation {
    condition     = can(regex("^([Tt]rue|[Ff]alse)$", var.PostcallCTRImportEnabled))
    error_message = "The PostcallCTRImportEnabled must be True(true) or False(false)."
  }
}

variable "HistoricalReportingImportEnabled" {
  type        = string
  description = "Set to false if importing Historical Reporting into Salesforce should not be enabled."

  validation {
    condition     = can(regex("^([Tt]rue|[Ff]alse)$", var.HistoricalReportingImportEnabled))
    error_message = "The HistoricalReportingImportEnabled must be True(true) or False(false)."
  }
}

variable "RealtimeReportingImportEnabled" {
  type        = string
  description = "Set to false if importing Realtime Reporting into Salesforce should not be enabled."

  validation {
    condition     = can(regex("^([Tt]rue|[Ff]alse)$", var.RealtimeReportingImportEnabled))
    error_message = "The RealtimeReportingImportEnabled must be True(true) or False(false)."
  }
}

variable "ContactLensImportEnabled" {
  type        = string
  description = "Set to false if importing Contact Lens into Salesforce should not be enabled."

  validation {
    condition     = can(regex("^([Tt]rue|[Ff]alse)$", var.ContactLensImportEnabled))
    error_message = "The ContactLensImportEnabled must be True(true) or False(false)."
  }
}

variable "PrivateVpcEnabled" {
  type        = string
  description = "Set to true if functions should be deployed to a private VPC, set VpcSecurityGroupList and VpcSubnetList if true"

  validation {
    condition     = can(regex("^([Tt]rue|[Ff]alse)$", var.PrivateVpcEnabled))
    error_message = "The PrivateVpcEnabled must be True(true) or False(false)."
  }
}