variable "instances_per_subnet" {
  description = "Number of VM instances to deploy per private subnet"
  type        = number
  default     = 1
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key file for VM admin login"
  type        = string
  default     = "C:/Users/Owner/.ssh/id_rsa.pub"
}