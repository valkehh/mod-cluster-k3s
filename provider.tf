# Define required providers
terraform {
required_version = ">= 1.9.4"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "2.1.0"
    }
  }
}