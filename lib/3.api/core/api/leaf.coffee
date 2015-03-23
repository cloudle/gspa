Wings.Enum.nodeTypes =
  property: 1
  method  : 2
  example : 3

Wings.Api.isValidMachineLeaf = (leafOjb) ->
  if Match.test(leafOjb.name, String) and leafOjb.name.length < 1
    return { valid: false, message: "invalid leaf name!" }
  if Match.test(leafOjb.parentId, String) and leafOjb.parentId.length < 1
    return { valid: false, message: "invalid leaf parent!" }
  return { valid: true }

Wings.Api.insertMachineLeaf = (name, nodeType, returnType, parentId) ->
  newLeaf = {name: name}
  newLeaf.nodeType = nodeType if nodeType
  newLeaf.returnType = returnType if returnType
  newLeaf.parentId = parentId if parentId

  validation = Wings.Api.isValidMachineLeaf(newLeaf)
  (console.log validation.message; return ) if !validation.valid

  Model.ApiMachineLeaf.insert(newLeaf)
