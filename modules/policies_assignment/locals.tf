locals {
  tags_to_enforce = var.enforce_all_tags ? keys(var.common_tags) : var.enforce_tags_list

    # ---------------------------
    # APP SERVICES
    # ---------------------------
  default_app_service_security_policies = {
    remote_debugging_disabled = {
      name                 = "app-service-disable-remote-debugging"
      display_name         = "Ensure remote debugging is not enabled for App Services"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0912.09s1Organizational.4"
    }

    no_open_cors = {
      name                 = "app-service-no-open-cors"
      display_name         = "Ensure no open CORS policy"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0949.09y2Organizational.5"
    }

    app_service_authentication = {
      name                 = "app-service-authentication-enabled"
      display_name         = "Ensure App Service Authentication is set"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/AppService_AuthEnabled"
    }

    app_service_http_to_https = {
      name                 = "app-service-enforce-https"
      display_name         = "Ensure web apps redirect HTTP traffic to HTTPS"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/AppService_HTTPS_Only"
    }

    app_service_ftps_disabled = {
      name                 = "app-service-ftps-disabled"
      display_name         = "Ensure FTP/FTPS deployments are disabled"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/AppService_RequireFTPS"
    }

    app_service_managed_identity = {
      name                 = "app-service-managed-identity-enabled"
      display_name         = "Ensure Managed Identity provider is enabled for App Services"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/AppService_ManagedIdentity_Require"
    }

    app_service_detailed_errors = {
      name                 = "app-service-detailed-error-disabled"
      display_name         = "Ensure detailed error messages are disabled"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/AppService_DetailedErrorMessages_Disabled"
    }

    app_service_use_azure_files = {
      name                 = "app-service-use-azure-files"
      display_name         = "Ensure App Services use Azure Files for content"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/AppService_WebApp_StorageAccountRequired_Audit"
    }
  }
  # ---------------------------
  # STORAGE ACCOUNTS
  # ---------------------------
  default_storage_account_security_policies = {
    storage_https_only = {
      name                 = "storage-https-only"
      display_name         = "Ensure enable_https_traffic_only is enabled for storage accounts"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/StorageAccounts_HTTPS_Required"
    }

    blob_private_access = {
      name                 = "storage-blob-private-access"
      display_name         = "Ensure Public access level is set to Private for blob containers"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/StorageAccounts_ContainerPrivate"
    }

    storage_deny_default_network = {
      name                 = "storage-deny-default-network"
      display_name         = "Ensure default network access rule for storage accounts is set to deny"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/StorageAccounts_NetworkAcls"
    }

    storage_trusted_microsoft_services = {
      name                 = "storage-trusted-microsoft-services"
      display_name         = "Ensure Trusted Microsoft Services is enabled for Storage account access"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/StorageAccounts_TrustedMicrosoftServices"
    }
  }
  # ---------------------------
  # VIRTUAL MACHINES
  # ---------------------------
  default_virtual_machine_security_policies = {
    vm_use_ssh_key = {
      name                 = "vm-use-ssh-key"
      display_name         = "Ensure Azure VM does not use basic authentication (use SSH key instead)"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/VMAgentUseSshKey"
    }

    vm_agent_installed = {
      name                 = "vm-agent-installed"
      display_name         = "Ensure VM agent is installed on all virtual machines"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/VMGuestAgent"
    }

    vm_disks_no_public_access = {
      name                 = "vm-disks-no-public-access"
      display_name         = "Ensure Azure VM disks are configured without public network access"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/DisablePublicNetworkAccessForDisks"
    }
  }
    # ---------------------------
    # SQL DATABASES
    # ---------------------------
  default_sql_database_security_policies = {
    sql_firewall_restrictive = {
      name                 = "sql-firewall-restrictive"
      display_name         = "Ensure Azure SQL server firewall is not overly permissive"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/SQLServerFirewallRulesThatCanAllowAllWindowsIPs"
    }

    azure_sql_defender = {
      name                 = "azure-sql-defender"
      display_name         = "Ensure Azure Defender is set on for Azure SQL database servers"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/EnableAzureDefenderForSqlServers"
    }

    sql_disable_public_network = {
      name                 = "sql-disable-public-network"
      display_name         = "Ensure SQL server disables public network access"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/SQLServer_DisablePublicNetworkAccess"
    }

    mysql_threat_detection = {
      name                 = "mysql-threat-detection"
      display_name         = "Ensure MySQL server enables threat detection policy"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/MySqlServerThreatDetection"
    }
    postgres_threat_detection = {
      name                 = "postgres-threat-detection"
      display_name         = "Ensure PostgreSQL server enables threat detection policy"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/PostgreSqlServerThreatDetection"
    }
    sql_audit_enabled = {
      name                 = "sql-audit-enabled"
      display_name         = "Ensure SQL server auditing is enabled"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/SQLServer_Auditing_Enabled"
    }
    sql_enforce_tls = {
      name                 = "sql-enforce-tls"
      display_name         = "Ensure SQL server enforces TLS 1.2 or higher"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/SQLServer_EnforceTLS"
    }
    sql_enforce_data_encryption = {
      name                 = "sql-enforce-data-encryption"
      display_name         = "Ensure SQL server data encryption is enforced"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/SQLServer_EnforceDataEncryption"
    }
  }
    # ---------------------------
    # KEY VAULTS
    # ---------------------------
  default_key_vault_security_policies = {
    key_vault_expiration = {
      name                 = "key-vault-expiration"
      display_name         = "Ensure expiration is set on all keys for Key Vaults"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/KeyVault_Secrets_Expire"
    }

    key_vault_recoverable = {
      name                 = "key-vault-recoverable"
      display_name         = "Ensure Key Vault is recoverable"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/KeyVault_RecoveryEnabled"
    }

    key_vault_no_public_network = {
      name                 = "key-vault-no-public-network"
      display_name         = "Ensure Azure Key Vault disables public network access"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/KeyVault_DisablePublicNetwork"
    }

    key_vault_private_endpoint = {
      name                 = "key-vault-private-endpoint"
      display_name         = "Ensure private endpoint is configured to Key Vault"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/KeyVault_RequirePrivateEndpoint"
    }

    key_vault_purge_protection = {
      name                 = "key-vault-purge-protection"
      display_name         = "Ensure Key Vault enables purge protection"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/KeyVault_EnablePurgeProtection"
    }

    key_vault_firewall_rules = {
      name                 = "key-vault-firewall-rules"
      display_name         = "Ensure Key Vault allows firewall rules settings"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/KeyVault_FirewallRulesAllowed"
    }

    key_vault_soft_delete = {
      name                 = "key-vault-soft-delete"
      display_name         = "Ensure Key Vault enables soft delete"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/KeyVault_EnableSoftDelete"
    }

    key_vault_hsm_key = {
      name                 = "key-vault-hsm-key"
      display_name         = "Ensure Key Vault key is backed by HSM"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/KeyVault_UseHSMForKeys"
    }
  }
    # ---------------------------
    # FUNCTION APPS
    # ---------------------------
  default_function_app_security_policies = {
    function_app_authentication = {
      name                 = "function-app-authentication"
      display_name         = "Ensure Function Apps enable authentication"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/AppService_FunctionAuth_Enabled"
    }

    function_app_https_only = {
      name                 = "function-app-https-only"
      display_name         = "Ensure Function Apps only accessible over HTTPS"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/FunctionApp_HTTPS_Only"
    }

    function_app_public_access_disabled = {
      name                 = "function-app-public-access-disabled"
      display_name         = "Ensure Azure Function App public network access is disabled"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/FunctionApp_DisablePublicAccess"
    }

    function_app_builtin_logging = {
      name                 = "function-app-builtin-logging"
      display_name         = "Ensure Function Apps builtin logging is enabled"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/FunctionApp_EnableBuiltinLogging"
    }

    function_app_http_version_latest = {
      name                 = "function-app-http-version-latest"
      display_name         = "Ensure Function App uses the latest HTTP version if configured"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/FunctionApp_RequireLatestHttpVersion"
    }
  }
    # ---------------------------
    # DEFENDER & MONITORING
    # ---------------------------
  default_defender_and_monitoring_security_policies = {
    azure_defender_app_service_servers = {
      name                 = "azure-defender-app-service-servers"
      display_name         = "Ensure Azure Defender is set to On for App Service and servers"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/EnableAzureDefenderForAppServicesAndServers"
    }

    activity_log_retention_365 = {
      name                 = "activity-log-retention-365"
      display_name         = "Ensure Activity Log retention is set to 365 days or greater"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/SetActivityLogRetention"
      parameters = {
        retentionInDays = {
          value = 365
        }
      }
    }
  }

  # Tag enforcement policies
  default_tag_policies = {
    for tag in local.tags_to_enforce : tag => {
      name                 = "enforce-tag-${tag}"
      display_name         = "Enforce Tag: ${tag}"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/require-tag"
      parameters = {
        tagName = { value = tag }
      }
    }
  }

  merged_policies = merge(
    var.policies,
    local.default_app_service_security_policies,
    local.default_sql_database_security_policies,
    local.default_key_vault_security_policies,
    local.default_function_app_security_policies,
    local.default_defender_and_monitoring_security_policies,
    local.default_tag_policies
  )

  policy_name         = "baseline"
  policy_display_name = "Zero Trust Baseline Policy Set"
  policy_description  = "Baseline enforcing key security policies like HTTPS only, Defender, access restrictions, logging, and identity controls."
  assignment_code     = "pset01"
}
