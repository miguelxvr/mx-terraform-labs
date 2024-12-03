resource "aws_ses_domain_identity" "domain_identity" {
  domain = var.domain
}