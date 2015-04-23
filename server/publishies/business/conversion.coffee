Schema.Conversion.allow
  insert: (userId, conversion)->
    cloneSource = {}; cloneSource[key] = value for key, value of conversion
    isValidSchema = Wings.IRUS.validate(cloneSource, Wings.Validators.conversionInsert)
    return isValidSchema.valid

  update: (userId, conversion, fieldNames, modifier)-> true
  remove: (userId, conversion)-> true