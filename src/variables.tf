variable "aws_account_id" {}

variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
  default     = "us-east-1"
}

variable "external_dns_chart_version" {
  description = "External-dns Helm chart version to deploy. 6.20.4 is the minimum version for this function"
  type        = string
  default     = "6.20.4"
}

variable "external_dns_chart_log_level" {
  description = "External-dns Helm chart log leve. Possible values are: panic, debug, info, warn, error, fatal"
  type        = string
  default     = "debug"
}

variable "external_dns_zoneType" {
  description = "External-dns Helm chart AWS DNS zone type (public, private or empty for both)"
  type        = string
  default     = ""
}

variable "external_dns_domain_filters" {
  description = "External-dns Domain filters."
  type        = list(string)
  default     = ["priyanka.com"]
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
  default     = "eks-cluster"
}

