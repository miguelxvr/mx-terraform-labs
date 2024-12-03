
output "domain" {
	value = aws_ses_domain_identity.domain_identity.domain
}

output "verification_token" {
	value = aws_ses_domain_identity.domain_identity.verification_token
}
