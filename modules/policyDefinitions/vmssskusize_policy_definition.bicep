targetScope = 'subscription'

resource vmssPolicyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Cloudies_allowedVMScaleSetSkuSize'
  properties: {
    description: 'Allowed VM Scale Set Sku Size'
    policyType: 'Custom'
    mode: 'All'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Compute/virtualMachineScaleSets'
          }
          {
            not: {
              field: 'Microsoft.Compute/virtualMachineScaleSets/sku.name'
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

output resourceId string = vmssPolicyDefinition.id
