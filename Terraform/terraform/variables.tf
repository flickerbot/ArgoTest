variable "app1_managed_by_terraform" {
  description = "Whether app1 should be managed by Terraform"
  type        = bool
  default     = true
}

variable "app1_replicas" {
  description = "Number of replicas for app1"
  type        = number
  default     = 1
}