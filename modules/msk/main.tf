resource "aws_msk_cluster" "kafka" {

cluster_name = "${var.project_name}-msk"

kafka_version = "3.5.1"

number_of_broker_nodes = 2

broker_node_group_info {

instance_type = "kafka.t3.small"

client_subnets = [
  var.private_subnet_a,
  var.private_subnet_b
]

security_groups = [
  var.msk_sg
]


}
}
