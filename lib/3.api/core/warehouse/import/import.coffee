Import = Wings.Warehouse.Import = {}

Import.isValidImport = (importObj)->
  if importObj.description and Wings.Validation.validString(importObj.description)
    return { valid: false, message: "invalid import description!" }

  if importObj.provider and Wings.Validation.validString(importObj.provider)
    return { valid: false, message: "invalid import provider!" }

  if importObj.importCode and Wings.Validation.validString(importObj.importCode)
    return { valid: false, message: "invalid import importCode!" }

  if importObj.warehouse and Wings.Validation.validString(importObj.warehouse)
    return { valid: false, message: "invalid import warehouse!" }

  return { valid: true }

Import.isValidDescription = (description, importId)->
  if Meteor.isClient
    if Wings.Validation.validString(importId)
      return { valid: false, message: "invalid import id!" }

  if Wings.Validation.validString(description)
    return { valid: false, message: "invalid import description!" }

  return { valid: true }

Import.isValidProvider = (providerId, importId)->
  if Meteor.isClient
    if Wings.Validation.validString(importId)
      return { valid: false, message: "invalid import id!" }

  if Wings.Validation.validString(providerId)
    return { valid: false, message: "invalid import provider!" }

  return { valid: true }

Import.isValidDepositCash = (depositCash, importId)->
  if Meteor.isClient
    if Wings.Validation.validString(importId)
      return { valid: false, message: "invalid import id!" }

  if Wings.Validation.validNumber(depositCash)
    return { valid: false, message: "invalid import depositCash!" }

  return { valid: true }

Import.isValidRemove = (importId)->
  if Wings.Validation.validString(importId)
    return { valid: false, message: "invalid import id!" }

  return { valid: true }



Import.insert = (description, provider, importCode, warehouse)->
  newImport = {}
  newImport.description = description if description
  newImport.provider    = provider if provider
  newImport.importCode  = importCode if importCode
  newImport.warehouse   = warehouse if warehouse

  validation = Import.isValidImport(newImport)
  if !validation.valid
    console.log validation.message
    return

  Model.Import.insert(newImport)

Import.updateDescription = (description, importId)->
  validation = Import.isValidDescription(description, importId)
  if !validation.valid
    console.log validation.message
    return

  Model.Import.update importId, $set: {description: description}

Import.updateProvider = (providerId, importId)->
  validation = Import.isValidProvider(providerId, importId)
  if !validation.valid
    console.log validation.message
    return

  Model.Import.update importId, $set: {provider: providerId}

Import.updateDepositCash = (depositCash, importId)->
  deposit = Wings.Convert.toNumberAsb(depositCash)
  validation = Import.isValidDepositCash(deposit, importId)
  if !validation.valid
    console.log validation.message
    return

  Model.Import.update importId, $set: {depositCash: deposit}

Import.remove = (importId)->
  validation = Import.isValidRemove(importId)
  if !validation.valid
    console.log validation.message
    return

  Model.Import.remove importId