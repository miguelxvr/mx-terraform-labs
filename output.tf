output "vpc_id" {
    value = "${module.vpc.vpc_id}"
}

output "vpc_cidr_block" {
    value = "${module.vpc.vpc_cidr_block}"
}

output "public_subnets" {
    value = "${module.vpc.public_subnets}"
}

output "private_subnets" {
    value = "${module.vpc.private_subnets}"
}

output "database_subnets" {
    value = "${module.vpc.database_subnets}"
}

#output "ecs_cluster_name" {
#    value = "${module.ecs_cluster.cluster_name}"
#}

#output "ecs_cluster_arn" {
#    value = "${module.ecs_cluster.cluster_arn}"
#}