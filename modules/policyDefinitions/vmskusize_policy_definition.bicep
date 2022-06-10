targetScope = 'subscription'

resource vmSizePolicyDefiniton 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Cloudies_allowedVmSizePolicy'
  properties: {
    description: 'Allowed VM sku Size'
    policyType: 'Custom'
    mode: 'All'
    policyRule: {
      if: {
        allOf:[
          {
            field: 'type'
            equals: 'Microsoft.Compute/virtualMachines'
          }
          {
            not: {
              field: 'Microsoft.Compute/virtualMachines/sku.name'
              equals: 'Standard_B2s'
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

output resourceId string = vmSizePolicyDefiniton.id
