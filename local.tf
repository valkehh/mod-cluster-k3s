locals {
  cluster_full_friendly_name = "${var.cluster_name}-${var.cluster_role}-${var.cluster_site}"
  cluster_domain_prefix = "${var.cluster_name}.${var.cluster_role}.${var.cluster_site}"
}

# locals {
#   hosts = {
#     instance.name = {
#       fixed_ip = instance.network.0.fixed_ip_v4
#       public_ip = ""
#       groups = var.instance_groups
#       variables = {
#         instance_name      = instance.name
#         instance_ip  = instance.network.0.fixed_ip_v4
#       }
#     }
#   }
# }

# locals {
#   ansible_hosts = merge(module.instances.hosts, module.bastion.hosts)
# }