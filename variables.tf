variable "cluster_name" {
  type    = string
  default = "cl1"
}

variable "cluster_role" {
  type    = string
  default = "dev"
}

variable "cluster_site" {
  type    = string
  default = "hell1"
}

variable "net_external_network" {
  type        = string
  description = "The ID of the external OpenStack network"
}

variable "net_internal_router" {
  type    = string
  description = "The ID of the internal router. Needs to be created beforehand."
}

variable "net_subet_cidr" {
  type        = string
  default     = "10.15.0.0/24"
}

variable "net_subnet_allocation_pool" {
  type = object({
    end   = string
    start = string
  })
  default = {
    end   = "10.15.0.252"
    start = "10.15.0.10"
  }
}

# variable "net_floating_ips" {
#   description = "A map of floating IP configurations"
#   type = map(object({
#     name : string
#     ip   : optional(string)
#   }))
#   default = {}
# }

variable "net_allowed_ips" {
  type = list(string)
}

variable "instance_image_id" {
  type    = string
  default = "7347976f-e269-4357-8691-2fb9ff45b1e1"
}

variable "instance_count" {
  type    = number
  default = 3
}

variable "instance_flavor" {
  type    = string
  default = "general1-1"
}

variable "instance_boot_volume_size" {
  type    = number
  default = 10
}

variable "instance_ssh_public_keys" {
  description = "List of public SSH keys"
  type    = list(string)

}
