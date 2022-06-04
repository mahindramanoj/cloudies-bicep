// Bicep module to create a custom role tailored to specific set of actions

@description('GUID of the custom RBAC role definition')
param rbacDefinitionGuid string

@description('Scope of the custom RBAC Role')
param scopeId string

param roleNameSuffix string = utcNow()

resource customRbacRoleDefinition 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' = {
  name: rbacDefinitionGuid
  properties: {
    roleName: 'Cloudies Contributor ${roleNameSuffix}'
    description: 'RBAC role for the members of the cloudies group that has set of permissions tailored to their needs'
    type: 'customRole'
    permissions: [
      {
        actions: [
          'Microsoft.Authorization/*/read'
          'Microsoft.Authorization/policyAssignments/*'
          'Microsoft.Authorization/policyDefinitions/*'
          'Microsoft.Authorization/policyExemptions/*'
          'Microsoft.Authorization/policySetDefinitions/*'
          //'Microsoft.ApiManagement/*'
          'Microsoft.AlertsManagement/smartDetectorAlertRules/*'
          'Microsoft.AlertsManagement/actionRules/*'
          'Microsoft.AlertsManagement/alertsSummary/*'
          'Microsoft.AlertsManagement/smartGroups/*'
          'Microsoft.AlertsManagement/migrateFromSmartDetection/*'
          'Microsoft.Automation/automationAccounts/*'
          'Microsoft.Advisor/configurations/read'
          'Microsoft.Advisor/recommendations/read'
          'Microsoft.Billing/billingPeriods/read'
          'Microsoft.Billing/billingProperty/read'
          'Microsoft.Compute/availabilitySets/*'
          'Microsoft.Compute/locations/*'
          'Microsoft.Compute/virtualMachines/*'
          'Microsoft.Compute/virtualMachineScaleSets/*'
          'Microsoft.Consumption/*/read'
          'Microsoft.CostManagement/*/read'
          //'Microsoft.DevOps/pipelines/*'
          'Microsoft.Insights/actiongroups/*'
          'Microsoft.Insights/activityLogAlerts/*'
          'Microsoft.Insights/alertrules/*'
          //'Microsoft.Insights/alertrules/alerts/*'
          'Microsoft.Insights/components/*'
          'Microsoft.Insights/createNotifications/*'
          'Microsoft.Insights/dataCollectionEndpoints/*'
          'Microsoft.Insights/dataCollectionRules/*'
          'Microsoft.Insights/dataCollectionRuleAssociations/*'
          'Microsoft.Insights/diagnosticSettings/*'
          'Microsoft.Insights/eventtypes/*'
          'Microsoft.Insights/LogDefinitions/*'
          'Microsoft.Insights/generateLiveToken/read'
          'Microsoft.Insights/metricAlerts/*'
          'Microsoft.Insights/MetricDefinitions/*'
          'Microsoft.Insights/Metrics/*'
          'Microsoft.Insights/notificationStatus/*'
          'Microsoft.Insights/Register/Action'
          'Microsoft.Insights/scheduledqueryrules/*'
          'Microsoft.Insights/topology/read'
          'Microsoft.Insights/transactions/read'
          'Microsoft.Insights/webtests/*'
          'Microsoft.KeyVault/vaults/*'
          'Microsoft.Logic/workflows/*'
          'Microsoft.ManagedIdentity/identities/read'
          'Microsoft.ManagedIdentity/userAssignedIdentities/assign/action'
          'Microsoft.ManagedIdentity/userAssignedIdentities/read'
          'Microsoft.ManagedIdentity/userAssignedIdentities/write'
          'Microsoft.ManagedIdentity/userAssignedIdentities/delete'
          'Microsoft.Network/*'
          'Microsoft.OperationalInsights/workspaces/*'
          'Microsoft.ResourceHealth/*'
          'Microsoft.Resources/deployments/*'
          //'Microsoft.Resources/subscriptions/resourceGroups/read'
          'Microsoft.RecoveryServices/vaults/*'
          'Microsoft.Resources/subscriptions/read'
          'Microsoft.Resources/subscriptions/resourceGroups/delete'
          'Microsoft.Resources/subscriptions/resourceGroups/read'
          'Microsoft.Resources/tags/*'
          'Microsoft.Sql/servers/*'
          'Microsoft.Sql/locations/*/read'
          'Microsoft.Sql/locations/instanceFailoverGroups/*'
          'Microsoft.Sql/managedInstances/*'
          'Microsoft.Storage/storageAccounts/*'
          //'Microsoft.Web/certificates/*'
          'Microsoft.Web/serverFarms/*'
          'Microsoft.Web/sites/*'
        ]
        notActions: [
        ]
        dataActions: []
        notDataActions: []
      }
    ]
    assignableScopes: [
      scopeId
    ]
  }
}

output resourceID string = customRbacRoleDefinition.id
