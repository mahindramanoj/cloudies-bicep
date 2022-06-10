targetScope = 'subscription'

resource aspPolicyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Cloudies_appServicePlanSku'
  properties: {
    description: 'Allowed app service plan'
    mode: 'All'
    policyType: 'Custom'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            notequals: 'Microsoft.Web/serverFarms'
          }
          {
            field: 'Microsoft.Web/serverFarms/sku.tier'
            notequals: 'Free'
          }
          {
            field: 'Microsoft.Web/serverFarms/sku.name'
            notequals: 'F1'
          }
        ]  
      }
      then: {
        effect: 'Deny'
      }
    }
  }
}

output resourceID string = aspPolicyDefinition.id
