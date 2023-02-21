# generate "backend" {
#   path      = "backend.tf"
#   if_exists = "overwrite_terragrunt"
#   contents = <<EOF

# EOF
# }

remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    project = "sandbox-376723"
    bucket = "batch5-terraform-state"
    prefix = "tf-batch5-iac/${path_relative_to_include()}/terraform.tfstate"
  }
}
