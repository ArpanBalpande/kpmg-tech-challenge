resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform_lock"
  read_capacity  = 5
  write_capacity = 5
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    "Name" = "DynamoDB Terraform State Lock Table"
  }
}
