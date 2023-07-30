
variable "region" { #это переменная её можно использовать в коде для любых переменных
  description = "Please Enter AWS Region to deploy Server"
  type        = string #линейное написание, его можно писать а можно и нет
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "Type instance"
  type        = string
  default     = "t2.micro"
}

variable "allow_ports" {
  description = "List of port to open for Server"
  type        = list(any) # перечисление тоесть лист когда много переменных
  default     = ["80", "443", "22", "8080"]
}

variable "common_tags" {
  description = "Common Tags to apply all resourse"
  type        = map(any)
  default = {
    Owner       = "Bizon Nik"
    Project     = "Megatron"
    CostCenter  = "12345777777"
    Environment = "development"
  }
}
