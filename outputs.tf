output "s3_bucket_arn" {
    value       = aws_s3_bucket.tf-state.arn
    description = "ARN of the S3 bucket"
}

output "dynamodb_table_name" {
    value       = aws_dynamodb_table.tf-state-lock.name
    description = "Dynamodb table used for state locking"
}