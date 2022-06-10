//targetScope = 'resourceGroup'

param initiativeAssignmentId string

param policySetAssignmentName string

resource policySetAssign 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: policySetAssignmentName
  properties: {
    policyDefinitionId: initiativeAssignmentId
  }
}
output policySetAssignmentId string = policySetAssign.id
