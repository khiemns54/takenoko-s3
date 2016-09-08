# Takenoko::S3

Plugin for [Takenoko](https://github.com/khiemns54/takenoko) to work with AWS S3

## Installation

```
gem 'takenoko-s3'
```

Refer takenoko document for generate initializer and basic config
Additional global configuration:

Example: config/initializers/takenoko.rb
    
    conf.s3.bucket = 'my_bucket'

|Option|Require|Default|Description|Value|Overwrite(*)|
|---|---|---|---|---|---|
|s3.aws_key_id|Require|nil|AWS key id|String|No|
|s3.aws_key_secret|Require|nil|AWS key secret|String|No|
|s3.to_s3|Optional|false|Allow all attached files to be uploaded to s3|bool|Yes|
|s3.bucket|Optional|nil|Bucket name|String|Yes|
|s3.file_location|Optional|attached_files|S3 location for uploaded files|String|Yes|
|s3.s3_public|Optional|attached_files|Make public after uploading|String|Yes|

##Usage

Takenoko

    Takenoko.upload_table_to_s3(table_name)
    Takenoko.upload_all_to_s3
    Takenoko.download_and_upload_table_to_s3(table_name)
    Takenoko.download_and_upload_all_to_s3

Rake

    rake takenoko:upload_table_to_s3[table_name]
    rake takenoko:upload_all_to_s3
    rake takenoko:download_and_upload_table_to_s3[table_name]
    rake takenoko:download_and_upload_all_to_s3
