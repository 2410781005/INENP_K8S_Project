variable "exoscale_cluster_name" {
    type = string
    description = "SKS Cluster Name"
}

variable "exoscale_key" {
  type        = string
  description = "Exoscale API Key"

}

variable "exoscale_secret" {
  type        = string
  description = "Exoscale API secret"
  sensitive   = true
}

variable "exoscale_zone" {
    type = string
    description = "Exoscale Deployment Zone"
    default = "at-vie-2"
}

variable "exoscale_sks_service_level" {
  type = string
  description = "Service Level Exoscale SKS"
  default = "starter"
}