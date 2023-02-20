variable "vm_name" {
  type    = list(string)
  default = ["vm-default"]
}

variable "vm_machine_type" {
  type = list(string)
}

variable "vm_zone" {
  type = string
}

variable "vm_image" {
  type = string
}

variable "vpc_id" {
  type = string
  default = "default"
}

variable "vpc_subnetwork_id" {
  type = string
  default = "default"
}

variable "project" {
  type    = string
}

variable "region" {
  type    = string
}

variable "zone" {
  type    = string
}

variable "ssh_pubkey" {
  type = string
}

variable "vm_tags" {
  type = list(string)
}