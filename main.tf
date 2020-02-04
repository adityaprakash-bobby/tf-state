provider "aws" {
    region = "ap-south-1"
}

resource "aws_s3_bucket" "tf-state" {
    bucket = "tf-state-lock"

    lifecycle {
        prevent_destroy = true
    }

    versioning {
        enabled = true
    }

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}

resource "aws_dynamodb_table" "tf-state-lock" {
    name         = "tf-state-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}


terraform {
    backend "s3" {
        # Configure bucket for stroing state
        bucket         = "tf-state-lock"
        key            = "global/s3/terraform.tfstate"
        region         = "ap-south-1"
        # Enable state locking using dynamodb and serverside encryption
        dynamodb_table = "tf-state-lock"
        encrypt        = true
    }
}