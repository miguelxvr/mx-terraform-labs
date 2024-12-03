# module "mariadb" {
#   source = "../modules/mariadb"

#   name_prefix = local.name_prefix

#   depends_on = [module.network]

#   username          = "admin"
#   vpc_id            = one(module.network[*].vpc_id)
#   subnet_group_name = one(module.network[*].database_subnet_group_name)
#   subnets           = one(module.network[*].database_subnets)

#   allocated_storage     = 60
#   max_allocated_storage = 100
#   instance_class        = "db.t4g.micro"

#   monitoring_interval = "0"

#   tags = local.tags
# }
