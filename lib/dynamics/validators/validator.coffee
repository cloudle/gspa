Module 'Wings.Validators',
  checkExistField: (fields, modelUpdateFields)->
    updateFields = []
    for field in Wings.Convert.toArray(fields)
      if _.contains(@[modelUpdateFields], field) then updateFields.push field
      else return {valid: false, error: "This is property (#{field}) does not exist, update Fail."}
    return {valid: true, data: updateFields}

  checkValidUpdateField: (fields, updateFields)->
    notPresentField = _.difference(fields, @[modelUpdateFields])
    if notPresentField.length > 0
      (return false if !_.contains(@[modelUpdateFields], field)) for field in notPresentField
    else
      return true