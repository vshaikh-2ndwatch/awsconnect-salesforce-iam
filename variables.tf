#Salesforce related variables

variable "SalesforceProduction" {
  type        = string
  description = "True for Production Environment, False for Sandbox"
  default     = "true"

  validation {
    condition     = can(regex("^([Tt]rue|[Ff]alse)$", var.SalesforceProduction))
    error_message = "The SalesforceProduction must be True(true) or False(false)."
  }
}

variable "SalesforceVersion" {
  type        = string
  description = "To find the Salesforce Edition and API Version please visit https://help.salesforce.com/articleView?id=000199268&type=1"
  default     = "v42.0"
}

variable "SalesforceCredentialsSecretsManagerARN" {
  type        = string
  description = "Enter the ARN for the Salesforce Credentials Secret in AWS Secrets Manager. This field is required."
}

variable "SalesforceCredentialsKMSKeyARN" {
  type        = string
  description = "Enter the ARN for the Salesforce Credentials KMS Key. This field is required."
}

variable "SalesforceAdapterNamespace" {
  type        = string
  description = "This is the namespace for CTI Adapter managed package. The default value is [amazonconnect]. If a non-managed package is used, leave this field blank."
  default     = "amazonconnect"
}

variable "SalesforceHost" {
  type        = string
  description = "Your Salesforce Host. Please make sure the host url starts with \"https\"."

  validation {
    condition     = can(regex("^$|^https(.*)", var.SalesforceHost))
    error_message = "Please make sure the host url starts with \"https\"."
  }
}

variable "SalesforceUsername" {
  type        = string
  description = "The username of a valid Salesforce API account for your environment. For example, user@domain.com"
}

#Amazon Connect related variables
variable "AmazonConnectInstanceId" {
  type        = string
  description = "Enter Amazon Connect Instance Id, the string after the last / in your Amazon Connect instance ARN (aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee). Not required if RealtimeReportingImportEnabled is set to false."
}

variable "AmazonConnectQueueMaxRecords" {
  type        = number
  description = "Enter record set size for list queue query. Max is 100."
  default     = 100
}

variable "AmazonConnectQueueMetricsMaxRecords" {
  type        = number
  description = "Enter record set size for queue metrics query. Max is 100."
  default     = 100
}

variable "LambdaLoggingLevel" {
  type        = string
  description = "Logging level for Lambda functions. Set one of the following DEBUG | INFO | WARNING | ERROR | CRITICAL"
  default     = "INFO"

  validation {
    condition     = contains(["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"], var.LambdaLoggingLevel)
    error_message = "Valid values for LambdaLoggingLevel are (DEBUG, INFO, WARNING, ERROR, CRITICAL)."
  }
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

variable "TranscriptionJobCheckWaitTime" {
  type        = number
  description = "Time between transcription job checks"
  default     = 20
}

variable "CTRKinesisARN" {
  type        = string
  description = "Enter Kinesis Stream ARN for CTR. Not required if PostcallCTRImportEnabled, PostcallRecordingImportEnabled and PostcallTranscribeEnabled all set to false"
  default     = ""
}

variable "CTREventSourceMappingMaximumRetryAttempts" {
  type        = number
  description = "Maximum retry attempts on failure for lambdas triggered by Kinesis Events"
  default     = 100
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
  #default     = "false"

  validation {
    condition     = can(regex("^([Tt]rue|[Ff]alse)$", var.PrivateVpcEnabled))
    error_message = "The PrivateVpcEnabled must be True(true) or False(false)."
  }
}

variable "VpcSecurityGroupList" {
  type        = list(string)
  description = "The list of SecurityGroupIds for the Virtual Private Cloud (VPC). Not required if PrivateVpcEnabled is set to false."
  #default     = [""]
}

variable "VpcSubnetList" {
  type        = list(string)
  description = "The list of Subnets for the Virtual Private Cloud (VPC). Not required if PrivateVpcEnabled is set to false."
  #default     = [""]
}















