variable "scope_id" {
  description = "Scope ID where the policies should be assigned (management group, subscription)."
  type        = string
  default     = null

  validation {
    condition = var.scope_id != null
    error_message = "scope_id is required."
  }
}

variable "scope_type" {
  description = "Type of scope: management_group | subscription."
  type        = string
  default     = null

  validation {
    condition = (
      var.scope_type == null ||
      contains(["management_group", "subscription"], var.scope_type)
    )
    error_message = "scope_type must be one of: management_group or subscription."
  }
}
 
variable "common_tags" {
  description = "Map of mandatory standard tags to enforce"
  type        = map(string)
  default     = {}
}

variable "enforce_all_tags" {
  description = "If true, enforce all tags in common_tags. If false, enforce only enforce_tags_list."
  type        = bool
  default     = true
}

variable "enforce_tags_list" {
  description = "Subset of tags from common_tags to enforce if enforce_all_tags = false"
  type        = list(string)
  default     = []
}

variable "policies" {
  description = "Policies to include in the initiative"
  type = map(object({
    name                 = string
    display_name         = string
    policy_definition_id = string
    parameters           = optional(map(any), {})
  }))
  default = {}
}