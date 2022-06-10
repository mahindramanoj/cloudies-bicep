targetScope = 'subscription'

resource locationPolicyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Cloudies_AllowedLocation'
  properties: {
    description: 'Allowed Location of the resources across the policy assignment'
    mode: 'All'
    policyType: 'Custom'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            in: [
              'Microsoft.Compute/*'
              'Microsoft.Storage/*'
              'Microsoft.Web/*'
              'Microsoft.keyVault/*'
              'Microsoft.ApiManager/*'
              'Microsoft.DataFactory/*'
              'Microsoft.Synapse/*'
              'Microsoft.Sql/*'
              'Microsoft.Network/*'
              'Microsoft.DevTestLabs/*'
              'Microsoft.ServiceBus/*'
              'Microsoft.EventHub/*'
              'Microsoft.OperationalInsights/*'
              'Microsoft.Resources/*'
            ]
          }
          {
            field: 'location'
            notequals: 'canadacentral' 
          }
        ]
      }
      then: {
        effect: 'Deny'
      }
    }
  }
}

output resourceId string = locationPolicyDefinition.id
