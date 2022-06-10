targetScope = 'subscription'

resource storageAccountKindPolicyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Cloudies_allowedStorageAccountKind'
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
              field: 'Microsoft.Storage/storageAccounts/sku.kind'
              in: [
                'StorageV2'
                'BlobStorage'
              ]
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

output resourceId string = storageAccountKindPolicyDefinition.id
