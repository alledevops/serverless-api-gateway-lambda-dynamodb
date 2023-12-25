variable "table_name" {
  description = "Name of the DynamoDB table to create"
  default     = "lambda-apigateway"
}
variable "accountId" {
  description = "AWS Account ID"
  type        = number
  default     = 920017674756
}
