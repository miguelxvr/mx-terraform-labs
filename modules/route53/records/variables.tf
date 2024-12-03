variable "zone_id" {
  type = string
  description = "The ID of the hosted zone to contain this record"
}

variable "name" {
  type = string
  description = "The name of the record"
}

variable "type" {
  type = string
  description = "The record type. Valid values are A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT"
}

variable "ttl" {
  type = string
  description = "The TTL of the record"
}

variable "records" {
  type = set(string)
  description = "A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM"
}