Wings.metaTest =
  name:
    type: String #String/[String], Number, Match.Integer, Boolean, undefined, null
    optional: true
    meta: [
      max: 10
      error: "Quá dài"
    ,
      min: 1
      error: "Quá ngắn"
    ]

  age:
    type: Match.Integer
    optional: true
    meta: [
      max: 100
      error: "Quá già để sử dụng"
    ,
      min: 10
      error: "Quá baby"
    ]

customMetaCheck = (source, key, obj) ->
  if !source[key] and obj.optional
    return {valid: true}
  else if !source[key] and !obj.optional
    return {valid: false, error: obj.optionalError ? "#{key} is required!", field: key}
  else if obj.meta
    if obj.type is String
      for currentMeta in obj.meta
        return {valid: false, error: currentMeta.error, field: key} if currentMeta.max and source[key].length > currentMeta.max
        return {valid: false, error: currentMeta.error, field: key} if currentMeta.min and source[key].length < currentMeta.min
    else if (obj.type is Number or obj.type is Match.Integer)
      for currentMeta in obj.meta
        return {valid: false, error: currentMeta.error, field: key} if currentMeta.max and source[key] > currentMeta.max
        return {valid: false, error: currentMeta.error, field: key} if currentMeta.min and source[key] < currentMeta.min

  return {valid: true}

Wings.Validation.check = (source, meta) ->
  pattern = {}

  for key, obj of meta
    if obj.optional
      pattern[key] = Match.Optional(obj.type)
    else
      pattern[key] = obj.type

    result = customMetaCheck(source, key, obj)
    return result unless result.valid

#  console.log pattern #for DEBUG!

  return {valid: true} if $.isEmptyObject(pattern)
  return {valid: Match.test(source, pattern)}


#Wings.Validation.check({name: "c"}, {age: {type: Number, meta: [{min: 18, error: "Quá nhỏ"}, {max: 200, error: "quá già"}]}, name: {type: String, optional: true, meta: [{max: 10, error: "tên quá dài bạn ơi"}, {min: 2, error: "tên quá vô lý"}]}})