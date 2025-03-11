variable "tfc_aws_dynamic_credentials" {
  description = "Object containing AWS dynamic credentials configuration"
  type = object({
    default = object({
      shared_config_file = string
    })
    aliases = map(object({
      shared_config_file = string
    }))
  })
}

provider "aws" {
  region = "us-east-1"
  shared_credentials_file = var.tfc_aws_dynamic_credentials.default.shared_config_file
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-123456"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "MyBucket"
    Environment = "Dev"
  }
}
