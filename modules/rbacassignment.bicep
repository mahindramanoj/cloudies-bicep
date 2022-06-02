// Bicep module to assign the custom rbac role defintion to Azure AD group named 'Cloudies' under the resource group scope

@description('Custom RBAC role DefinitionId')
param customRbacRoleDefinitionId string

@description('Cloudys Azure AD Group Object Id')
param cloudiesAADGroupId string

@description('Id of the resource group where the custom RBAC role is defined')
param resourceGroupId string

resource customRbacRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  name: guid(resourceGroupId, cloudiesAADGroupId, customRbacRoleDefinitionId)
  properties: {
    roleDefinitionId: customRbacRoleDefinitionId
    principalId: cloudiesAADGroupId
    principalType: 'Group'
  }
}

//output

@description('Resource Id of the custom RBAC role assignment to cloudies AAD group')
output rbacRoleAssignId string = customRbacRoleAssignment.id
