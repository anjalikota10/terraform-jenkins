variable "vpc_id" {
  type = string
}

variable "igw_id" {
  type = string
  default = ""
}

variable "nat_gateway_id" {
  type = string
  default = ""
}

variable "subnet_ids" {
  type = list(string)
}

variable "public" {
  type = bool
}
