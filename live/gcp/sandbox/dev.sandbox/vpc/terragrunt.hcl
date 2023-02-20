terraform {
  source = "../../../../..//modules/gcp/vpc"
}

inputs = {
  vpc_name      = "${include.environment.inputs.environment_name}-${include.project.inputs.project_short_name}-vpc"
  subnet_cidr   = "192.168.0.0/16"
  subnet_region = "${include.environment.inputs.default_region}"

  project = "${include.project.inputs.project_id}"
  region  = "${include.environment.inputs.default_region}"
  zone    = "${include.environment.inputs.default_zone}"

}

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