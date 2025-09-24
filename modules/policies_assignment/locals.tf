locals {
  tags_to_enforce = var.enforce_all_tags ? keys(var.common_tags) : var.enforce_tags_list
  default_security_policies = {
    enforce_https_storage = {
      name              = "enforce-https-storage"
      display_name       = "Enforce HTTPS on Storage Accounts"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6d53f73d-8e0a-4c3c-8b9a-d9a1bd173f7e"
    }
    enforce_sql_auditing = {
      name                = "enforce-sql-auditing"
      display_name         = "Enforce SQL Auditing"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/3a96a712-c985-4f03-8e9a-1ecb5f0a9395"
    }
    enforce_sql_encryption = {
      name                = "enforce-sql-encryption"  
      display_name         = "Enforce SQL Encryption"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/fedb99e4-5c59-4b8f-9b79-f4f487a38234"
    }
    prevent_ip_forwarding = {
      name                = "prevent-ip-forwarding"
      display_name         = "Prevent IP Forwarding"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/18d5f65a-f3c7-43f9-bcf8-6ae8a5fdfc5b"
    }
    prevent_rdp_internet = {
      name                = "prevent-rdp-internet"
      display_name         = "Prevent RDP from Internet"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/dcda2c2a-96a1-4f42-b0f9-9337f29f07ba"
    }
    subnet_nsg_association = {
      name                = "subnet-nsg-association"
      display_name         = "Subnet Network Security Group Association"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/94f0bd12-4d3a-4c16-84a6-0109c8b4ff58"
    }
  }
  default_policies={
    tag_policies = {
      for tag in local.tags_to_enforce : 
      tag => {
        name                = "enforce-tag-${tag}"
        display_name        = "Enforce Tag: ${tag}"
        policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/require-tag"
        parameters = {
          tagName = {
            value = tag
          }
        }
      }
    } 
  }

  merged_policies = merge(var.policies, local.default_security_policies, local.default_policies)
  policy_name = "baseline-policy-set"
  policy_display_name = "Baseline Policy Set"
  policy_description = "Policy set including default security, compliance, and tagging policies."
  asssignment_code = "asg"
}