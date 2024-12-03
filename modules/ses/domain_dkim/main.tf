resource "aws_ses_domain_dkim" "domain_dkim" {
  domain = var.domain
}