module "network" {
  source = "git::https://github.com/larnetio/o7k-modules-tf.git//network?ref=1.0.0"
  network_prefix = local.cluster_full_friendly_name
  external_network = var.net_external_network
  internal_router = var.net_internal_router
  subet_cidr = var.net_subet_cidr
  subnet_allocation_pool =  var.net_subnet_allocation_pool
}

module "bastion" {
  source = "git::https://github.com/larnetio/o7k-modules-tf.git//instance?ref=1.0.0"
  instance_name = "${local.cluster_full_friendly_name}-bastion"
  instance_metadata = {
    node_type = "bastion"
    ansible_groups = ["bastions"]
  }
  instance_groups = [local.cluster_full_friendly_name, "bastions"]
  image_id = var.instance_image_id
  instance_flavor = "compute1-8"
  boot_volume_size = var.instance_boot_volume_size
  ssh_public_keys = var.instance_ssh_public_keys
  network_id = module.network.network_id
  subnet_id = module.network.subnet_id
  security_group_default_id = module.network.security_group_default_id
  depends_on = [module.network]
}

module "bastion_fip" {
  source = "git::https://github.com/larnetio/o7k-modules-tf.git//fip?ref=1.0.0"
  port_id = module.bastion.port_id
  fip_pool = "public-network"
}

module "bastion_sec_group_ssh" {
  source = "git::https://github.com/larnetio/o7k-modules-tf.git//sec-ssh?ref=1.0.0"
  name = module.bastion.hostname
  allowed_ips = var.net_allowed_ips
}

module "k3s_instances" {
  source = "git::https://github.com/larnetio/o7k-modules-tf.git//instance?ref=1.0.0"
  count  = var.instance_count

  instance_name = "${local.cluster_full_friendly_name}-${count.index + 1}"
  instance_metadata = {
    node_type = "instance"
    k3s_type = "server"
    ansible_groups = "['k3s_servers']"
  }
  instance_groups = [local.cluster_full_friendly_name, "k3s_servers"]
  image_id = var.instance_image_id
  instance_flavor = var.instance_flavor
  boot_volume_size = var.instance_boot_volume_size
  # ssh_public_keys = concat(var.instance_ssh_public_keys, [module.bastion.public_ssh_key])
  ssh_public_keys = var.instance_ssh_public_keys
  network_id = module.network.network_id
  subnet_id = module.network.subnet_id
  security_group_default_id = module.network.security_group_default_id
  depends_on = [module.network]
}
