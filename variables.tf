variable "airline_name" {
    default = "airlinename"
    type= string
    description = "name of the new airline"
}

variable "client_id" {
  type=string
  description= "client_id credential"
}

variable "client_secret" {
  type=string
}

variable "tenant_id" {
  type=string
}

variable "subscription_id" {
  type=string
}

variable "object_id" {
  type=string
}

variable "address_range" {
  type=list(string)
}

variable "ip_address" {
  type=list(string)
}