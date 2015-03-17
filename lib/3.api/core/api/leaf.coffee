Wings.Enum.nodeTypes =
  property: 1
  method  : 2
  example : 3

Wings.Api.isValidMachineLeaf = (leafOjb) ->
  if !leafOjb.name || leafOjb.name.length < 1
    return { valid: false, message: "invalid node name!" }
  return { valid: true }

Wings.Api.insertTechLeaf = (name, nodeType, returnType, parentId) ->
  newLeaf = {name: name}
  newLeaf.nodeType = nodeType if nodeType
  newLeaf.returnType = returnType if returnType
  newLeaf.returnType = returnType if returnType

  validation = Wings.Api.isValidMachineLeaf(newLeaf)
  if !validation.valid
    console.log validation.message
    return

  leafId = Model.ApiMachineLeaf.insert(newLeaf)
