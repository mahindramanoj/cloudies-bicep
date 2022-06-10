targetScope = 'subscription'

resource storageAccountSkuPolicyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Cloudies_storageAccountSku'
  properties: {
    description: 'Allowed Storage Account Kind'
    policyType: 'Custom'
    mode: 'All'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Storage/storageAccounts'
          }
          {
            not: {
              field: 'Microsoft.Storage/storageAccounts/sku.name'
              equals: 'Standard_LRS'
            }
          }
        ]
      }
      then: {
        effect: 'Deny'
      }
    }
  }
}

output resourceId string = storageAccountSkuPolicyDefinition.id
