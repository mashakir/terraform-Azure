output "common_tags" {
  value = merge({
    ManagedBy = "Terraform"  
    Owner            = local.owner
    ProjectCode             = local.projectCode
    CostCenter          = local.costCenter
    Department          = local.department
    BusinessCriticality = local.businessCriticality
    Compliance         = local.compliance
  }, var.std_tags)
} 