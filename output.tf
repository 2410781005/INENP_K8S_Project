output "nlb_ip_address" {
  value = exoscale_nlb.web_nlb.ip_address
  description = "Public IP address of the Exoscale Load Balancer"
}
