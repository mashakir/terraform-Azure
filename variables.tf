variable "resource_group_name" {
  description = "Name of the resource group"

}
variable "location" {
  description = "location of the resource group"
}
variable "environment" {
  description = "Name of the environment"
}
variable "policy_scope_id" {
  type        = string
  description = "Scope ID where the policies should be assigned (management group or subscription)"
  default     = "contoso-mg"
}
variable "scope_type" {
  type        = string
  description = "Type of scope for baseline: management_group | subscription."
  default     = "management_group"
}