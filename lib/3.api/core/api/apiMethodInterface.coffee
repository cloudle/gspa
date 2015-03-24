class @Wings.Api.Param
  constructor: (@name) ->
  addType: (type) ->
    if !@type then @type = [type]
    else
      exist = _(@type).findWhere({name: type.name}) > 0
      @type.push type if !exist

  removeType: (name) ->
    return if !Array.isArray(@type)
    foundIndex = _(@type).findWhere({name: name})
    @type.splice(foundIndex, 1)

  @fromString = (source) ->
    results = []
    params = source.split(',')
    for param in params
      param = param.trim()
      typeSeparatorIndex = param.indexOf(":")

      if typeSeparatorIndex > 0
        namePart = param.substring(0, typeSeparatorIndex)
        typePart = param.substring(typeSeparatorIndex+1)
        result = new Wings.Api.Param(namePart)
        result.addType({name: typePart})
      else
        result = new Wings.Api.Param(param)

      results.push result

    results