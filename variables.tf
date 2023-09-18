variable "virginia_cidr" {
  description = "CIDR Virginia"
  type        = string
  sensitive   = false
}

# variable "public_subnet" {
#   description = "CIDR Public Subnet"
#   type        = string
#   sensitive   = false
# }

# variable "private_subnet" {
#   description = "CIDR Private Subnet"
#   type        = string
#   sensitive   = false
# }

variable "subnets" {
  description = "Lista de subnets"
  type        = list(string)
}

variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)

}

variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

variable "ec2_specs" {
  description = "Especificaciones de EC2 instance"
  type        = map(string)
}


variable "enable_monitoring" {
  description = "Habilita el despliegue el servidore de monitoreo"
  type        = number
}

variable "ingress_port_list" {
  description = "Lista de puertos del ingress"
  type        = list(number)
}

variable "access_key" {
}

variable "secret_key" {
}
