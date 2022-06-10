targetScope = 'subscription'

module aspPolicyDef 'br:cloudies.azurecr.io/policy/asp-sku:1.0' = {
  name: 'Cloudies_serverFarmPolicy'
}

module locationPolicyDef 'br:cloudies.azurecr.io/policy/location:1.0' = {
  name: 'Cloudies_locationPolicy'
}

module osDiskSkuPolicyDef 'br:cloudies.azurecr.io/policy/disk-sku:1.0' = {
  name: 'Cloudies_osDiskSkuPolicy'
}

module storageAccountKindPolicyDef 'br:cloudies.azurecr.io/policy/storage-account-kind:1.0' = {
  name: 'Cloudies_storageAccountKind'
}

module storageAccountSkuPolicyDef 'br:cloudies.azurecr.io/policy/storage-account-sku:1.0' = {
  name: 'Cloudies_storageAccountSku'
}

module vmskusizePolicyDef 'br:cloudies.azurecr.io/policy/vm-sku:1.0' = {
  name: 'Cloudies_vmSizeSku'
}

module vmssSkuSizePolicyDef 'br:cloudies.azurecr.io/policy/vmss-sku:1.0' = {
  name: 'Cloudies_vmssSizeSku'
}


resource policySetDefinition 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Cloudies'
  dependsOn: [
    aspPolicyDef
    locationPolicyDef
    osDiskSkuPolicyDef
    storageAccountKindPolicyDef
    storageAccountSkuPolicyDef
    vmskusizePolicyDef
    vmssSkuSizePolicyDef
  ]
  properties: {
    policyType: 'Custom'
    policyDefinitions: [
      {
        policyDefinitionId: aspPolicyDef.outputs.resourceID
      }
      {
        policyDefinitionId: locationPolicyDef.outputs.resourceId
      }
      {
        policyDefinitionId: osDiskSkuPolicyDef.outputs.resourceId
      }
      {
        policyDefinitionId: storageAccountKindPolicyDef.outputs.resourceId
      }
      {
        policyDefinitionId: storageAccountSkuPolicyDef.outputs.resourceId
      }
      {
        policyDefinitionId: vmskusizePolicyDef.outputs.resourceId
      }
      {
        policyDefinitionId: vmssSkuSizePolicyDef.outputs.resourceId
      }
    ]
  }
}

output resourceId string = policySetDefinition.id
