Module 'Wings.Validators',
  checkExistField: (fields, modelUpdateFields)->
    updateFields = []
    for field in Convert.toArray(fields)
      if _.contains(@[modelUpdateFields], field) then updateFields.push field
      else return {valid: false, error: "This is property (#{field}) does not exist, update Fail."}
    return {valid: true, data: updateFields}

  checkValidUpdateField: (fields, modelUpdateFields)->
    notPresentField = _.difference(fields, @[modelUpdateFields])
    if notPresentField.length > 0
      for field in notPresentField
        return false if !_.contains(@[modelUpdateFields], field)
    return true