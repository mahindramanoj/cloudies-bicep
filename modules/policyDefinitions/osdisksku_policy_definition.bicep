targetScope = 'subscription'


resource osdiskSkuPolicyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Cloudies_OsDiskSizeSku'
  properties: {
    description: 'Allowed VM sku Size'
    policyType: 'Custom'
    mode: 'All'
    policyRule: {
      if: {
        allOf:[
          {
            field: 'type'
            equals: 'Microsoft.Compute/disks'
          }
          {
            not: {
              field: 'Microsoft.Compute/disks/sku.name'
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

output resourceId string = osdiskSkuPolicyDefinition.id
