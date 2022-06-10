// main bicep file to create sandbox environment/ rg in azure with custom RBAC roles tailored for the needs.

targetScope = 'subscription'

@description('Name Prefix of the resource group')
param resourceGroupNamePrefix string

param resourceGroupNameSuffix string = utcNow()

param resourceLocation string = deployment().location

@description('Name of the person for whom this rg is for')
param initiatorFullName string


var resourceGroupName = 'cloudies-${resourceGroupNamePrefix}-${resourceGroupNameSuffix}-rg'

var cloudiesAADGroupId = '2078a69a-c18c-497c-8f6f-40872b7e91f7' //object ID of the Cloudys Azure Active Directory group

//var rbacDefinitionGuid = guid(resourceGroup().id, 'Cloudies Contributor')

// Gather existing custom policy definition resource
resource policySetDefinition 'Microsoft.Authorization/policySetDefinitions@2021-06-01' existing = {
  name: 'Cloudies'
}

// creates resource group 
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: toLower(resourceGroupName)
  location: resourceLocation
  tags: {
    createdBy: initiatorFullName
  }
}

// calls bicep module from azure container registry to create rbac definiton on rg
module customrbacdef 'br:cloudies.azurecr.io/iam/rbac-definition:1.1' = {
  scope: rg
  name: 'customRbacDefinition'
  params: {
    rbacDefinitionGuid: guid(rg.id, 'Cloudies Contributor ${resourceGroupNameSuffix}')
    scopeId: rg.id
  }
}

// calls bicep module from azure container registry to create rbac assignment on rg
module customrbacassign 'br:cloudies.azurecr.io/iam/rbac-assignment:1.0' = {
  scope: rg
  name: 'customRbacRoleAssignment'
  params: {
    cloudiesAADGroupId: cloudiesAADGroupId
    customRbacRoleDefinitionId: customrbacdef.outputs.resourceID
    resourceGroupId: rg.id
  }
}

// Assigns custom policy set definition to the resource group
module customInitiativeAssignment 'br:cloudies.azurecr.io/policy/initiative-assignment:1.0' = {
  name: 'policySetAssignment ${resourceGroupNameSuffix}'
  scope: rg
  params: {
    initiativeAssignmentId: policySetDefinition.id
  }
}
