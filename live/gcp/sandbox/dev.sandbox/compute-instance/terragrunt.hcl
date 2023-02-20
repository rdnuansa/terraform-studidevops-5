terraform {
  source = "../../../../..//modules/gcp/compute-instance/"
}

inputs = {
  vm_name           = ["${include.environment.inputs.environment_name}-app"]
  vm_image          = "image-test"
  vm_machine_type   = ["e2-small"]
  vm_tags           = ["webserver"]
  vm_zone           = "${include.environment.inputs.default_zone}"
  ssh_pubkey        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDp8U/vOSmFWxQYyw4DH7ea99gfwhk+8gaz8hm7+cxpf+FPgrGpGJVIyIy7tQLNDzqQOyq+rh42FHLSMekdLUABUeGZb1n6Un443wVQG7qKPbMYA9PniCA/lauXblwy3tQB1CDocwzOmjDdD64robSR7fB8KU7PpZEYzaoapwd++hW6JXeFIsT/RuxdQ2rDez0bA8s76ZpPzlC290SQXD+Bfe+svJ//oYr5YrwL/Z2k/w+KV44m/CpDM+FOJWR+2elA2EUdeKK4ElARAQWW2wJyKLjlDMLtcQvnqxIY7rAMEmkfRpHaWsDpaUSYDTPqxzmBZ1A388OxQ9uWuFBds/3cv2QvA/jCPopFme3Fb/Ho3DWCSjkVIlYEP2e3PNAw88t3ado03o0pMFpzqVKkbVGaYxhgCV5RatE0JDysaIaY+MJEMwGD0lUQFY2GC7R7ZmjHIjAzys81tQKddGX647cMxEJi+x0YNKSAvtIgXjoK5ySvw0RVyLx7etkyUacykBk= ryandito@accelbyte.net@Ryandito-AB-LInux"
  vpc_id            = dependency.vpc.outputs.vpc_id
  vpc_subnetwork_id = dependency.vpc.outputs.subnet_id

  project = "${include.project.inputs.project_id}"
  region  = "${include.environment.inputs.default_region}"
  zone    = "${include.environment.inputs.default_zone}"

}

## see: https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#dependency
dependency "vpc" {
  config_path = "../vpc"

  # mock_outputs = {
  #   vpc_id = "DUMMY_VPC_ID"
  #   subnet_id = "DUMMY_SUBNET_ID"
  # }
  # mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "apply", "destroy"]

}

## see: https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#include
include "environment" {
  path   = find_in_parent_folders("environment.hcl")
  expose = true
}

include "project" {
  path   = find_in_parent_folders("project.hcl")
  expose = true
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}