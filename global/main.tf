locals {
  workspace         = terraform.workspace
  # environment       = regex("[^-]*$", terraform.workspace)
  tags = {
      Terraform          = "true"
      TerraformWorkspace = terraform.workspace
  }
}
