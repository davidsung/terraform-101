variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment tag"
}

variable "cidr_block" {
  type        = string
  description = "Whitelist IP address for accessing http"
}
