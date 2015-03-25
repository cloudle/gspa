Wings.Api.Leaf =
  addParamType: (source, type) ->
    if !source.type then source.type = [type] else source.type.push type unless _(source.type).findWhere({name: type.name}) > 0

  removeParamType: (source, type) ->
    return if !Array.isArray(source.type)
    @type.splice(source.type.indexOf(_(source.type).findWhere({name: name})), 1)

  removeParam: (leafId, name) -> Model.ApiMachineLeaf.update(leafId, {$pull: {params: {name: name}}})

  addParams: (leafId, params) ->
    params = @generateParams(params) if typeof params is 'string'
    Model.ApiMachineLeaf.update(leafId, {$push: {params: {$each: params}}}) if Array.isArray(params)

  generateParams: (source) ->
    results = []
    params = source.split(',')
    for param in params
      param = param.trim()
      typeSeparatorIndex = param.indexOf(":")

      if typeSeparatorIndex > 0
        namePart = param.substring(0, typeSeparatorIndex)
        typePart = param.substring(typeSeparatorIndex+1)
        result = {name: namePart, type: [{name: typePart}]}
      else
        result = {name: param}

      results.push result

    results

#Wings.Api.isValidMachineLeaf = (leafOjb) ->
#  if Match.test(leafOjb.name, String) and leafOjb.name.length < 1
#    return { valid: false, message: "invalid leaf name!" }
#  if Match.test(leafOjb.parentId, String) and leafOjb.parentId.length < 1
#    return { valid: false, message: "invalid leaf parent!" }
#  return { valid: true }
#
#Wings.Api.insertMachineLeaf = (name, nodeType, returnType, parentId) ->
#  newLeaf = {name: name}
#  newLeaf.nodeType = nodeType if nodeType
#  newLeaf.returnType = returnType if returnType
#  newLeaf.parentId = parentId if parentId
#
#  validation = Wings.Api.isValidMachineLeaf(newLeaf)
#  (console.log validation.message; return ) if !validation.valid
#
#  Model.ApiMachineLeaf.insert(newLeaf)
#
#Wings.Api.insertLeafParam = (param) ->
