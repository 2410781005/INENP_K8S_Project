output "nlb_ip_address" {
  value = exoscale_nlb.oauth_lb.ip_address
  description = "Public IP address of the Exoscale Load Balancer"
}
