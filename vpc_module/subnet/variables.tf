variable "vpc_id" {
  type = string
}

variable "cidr_blocks" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "public" {
  type = bool
  default = false
}
