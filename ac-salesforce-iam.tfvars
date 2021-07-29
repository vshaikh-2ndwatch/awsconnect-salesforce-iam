SalesforceCredentialsSecretsManagerARN = "arn:aws:secretsmanager:us-east-1:139967329992:secret:SalesforceCredentials-lePUks"
SalesforceCredentialsKMSKeyARN         = "arn:aws:kms:us-east-1:139967329992:key/aeaa99cf-d4ed-4793-aac6-361596f76cf8"
SalesforceHost                         = "https://talech--tscdev.my.salesforce.com/"
SalesforceProduction                   = false
SalesforceUsername                     = "sfuser@talech.com"
SalesforceVersion                      = "v42.0"
SalesforceAdapterNamespace             = "amazonconnect"
LambdaLoggingLevel                     = "INFO"

CTRKinesisARN                             = "arn:aws:kinesis:us-east-1:139967329992:stream/ctr-salesforce-stream"
CTREventSourceMappingMaximumRetryAttempts = 100

PrivateVpcEnabled    = "true"
VpcSecurityGroupList = ["sg-e54cf6fd"]
VpcSubnetList        = ["subnet-9b1b8baa"]

HistoricalReportingImportEnabled = true
PostcallTranscribeEnabled        = true
RealtimeReportingImportEnabled   = true
ContactLensImportEnabled         = true
PostcallRecordingImportEnabled   = false
PostcallCTRImportEnabled         = true

AmazonConnectInstanceId = "i-1234567890abcdef0"

ConnectReportingS3BucketName = "testbucket"
ConnectRecordingS3BucketName = "testrecordingbucket"
TranscribeOutputS3BucketName = "transcribeoutputbucket"