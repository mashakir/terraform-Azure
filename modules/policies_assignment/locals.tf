locals {
  tags_to_enforce = var.enforce_all_tags ? keys(var.common_tags) : var.enforce_tags_list

  default_security_policies = {
    # ---------------------------
    # STORAGE – ZERO TRUST
    # ---------------------------
    enforce_https_storage = {
      name                = "enforce-https-storage"
      display_name         = "Enforce HTTPS on Storage Accounts"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6d53f73d-8e0a-4c3c-8b9a-d9a1bd173f7e"
    }

    enforce_storage_network_security = {
      name                = "enforce-storage-network-security"
      display_name         = "Enforce Storage Account Network Security (Private Access Only)"
      policy_definition_id = azurerm_policy_definition.storage_network_security.id
    }

    # ---------------------------
    # SQL – ZERO TRUST
    # ---------------------------
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

    sql_public_network_disabled = {
      name                = "disable-sql-public-network"
      display_name         = "Disable Public Network Access for SQL"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1f314764-cb73-4fc9-b863-8eca98ac36e9"
    }

    # ---------------------------
    # NETWORK – ZERO TRUST
    # ---------------------------
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

    deny_public_ip = {
      name                = "deny-public-ip"
      display_name         = "Deny Public IP Addresses"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/9f061a12-e40d-4183-a00e-171812443373"
    }

    subnet_nsg_association = {
      name                = "subnet-nsg-association"
      display_name         = "Subnet Network Security Group Association"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/94f0bd12-4d3a-4c16-84a6-0109c8b4ff58"
    }

    # ---------------------------
    # IDENTITY – ZERO TRUST
    # ---------------------------
    enforce_managed_identity = {
      name                = "require-managed-identity"
      display_name         = "Require Managed Identity on Azure Resources"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/60d21c4f-21a8-4e18-b09d-7f40f5b8b4a7"
    }

    # ---------------------------
    # MONITORING & DEFENDER
    # ---------------------------
    enable_defender = {
      name                = "enable-defender"
      display_name         = "Enable Microsoft Defender for Cloud"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1fbd5c48-3a95-4b92-8bba-9b0b5cc38b3d"
    }
  }

  default_policies = {
    tag_policies = {
      for tag in local.tags_to_enforce :
      tag => {
        name                 = "enforce-tag-${tag}"
        display_name         = "Enforce Tag: ${tag}"
        policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/require-tag"
        parameters = {
          tagName = {
            value = tag
          }
        }
      }
    }
  }

  merged_policies = merge(
    var.policies,
    local.default_security_policies,
    local.default_policies
  )

  policy_name         = "baseline-policy-set"
  policy_display_name = "Zero Trust Baseline Policy Set"
  policy_description  = "Zero Trust baseline enforcing private access, identity-based security, encryption, and monitoring."
  asssignment_code    = "asg"
}
