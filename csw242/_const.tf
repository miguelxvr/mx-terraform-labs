module "global" {
  source = "../global"
}

locals {
  domain      = "csw242"
  workspace   = module.global.workspace
  namespace   = "csw242"
  name_prefix = "${local.domain}-${local.workspace}"
  tags = merge(
    {
      Environment    = module.global.workspace
      BusinessOwner  = "CSW242 Team"
      TechnicalOwner = "DevOps"
      CostCentre     = "CCC001"
      CreatedBy      = "CSW242 Team"
      Domain         = local.domain
    },
    module.global.tags,
  )
}
