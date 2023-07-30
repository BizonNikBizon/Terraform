
variable "region" { #это переменная её можно использовать в коде для любых переменных
  description = "Please Enter AWS Region to deploy Server"
  type        = string #линейное написание, его можно писать а можно и нет
  default     = "eu-central-1"
}

variable "environment" {
  type    = string
  default = "DEV"
}

variable "project_name" {
  type    = string
  default = "TORNADO"
}


variable "owner" {
  type    = string
  default = "Bizon Nik"
}
