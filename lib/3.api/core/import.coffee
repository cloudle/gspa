Wings.Import = {}
Wings.Import.nextCode = ()->
Wings.Import.changStatus = ()->

Wings.Import.isValidImport = (importObj)->
  if Meteor.isClient
    return { valid: false, message: "you are not logged in" } if !Meteor.userId()

  if importObj.description and !Match.test(importObj.description, String)
    return { valid: false, message: "invalid import description!" }

  if importObj.provider and !Match.test(importObj.provider, String)
    return { valid: false, message: "invalid import provider!" }

  if importObj.importCode and !Match.test(importObj.importCode, String)
    return { valid: false, message: "invalid import importCode!" }

  if Match.test(importObj.warehouse, String)
    return { valid: false, message: "invalid import warehouse!" }

  return { valid: true }

Wings.Import.isValidDescription = (description, importId)->
  if Meteor.isClient
    return { valid: false, message: "you are not logged in" } if !Meteor.userId()

  if Match.test(importId, String)
    return { valid: false, message: "invalid import id!" }

  if Match.test(description, String)
    return { valid: false, message: "invalid import description!" }

  return { valid: true }

Wings.Import.isValidProvider = (providerId, importId)->
  if Meteor.isClient
    return { valid: false, message: "you are not logged in" } if !Meteor.userId()

  if Match.test(importId, String)
    return { valid: false, message: "invalid import id!" }

  if Match.test(providerId, String)
    return { valid: false, message: "invalid import provider!" }

  return { valid: true }

Wings.Import.isValidRemove = (importId)->
  if Meteor.isClient
    return { valid: false, message: "you are not logged in" } if !Meteor.userId()

  if Match.test(importId, String)
    return { valid: false, message: "invalid import id!" }

  return { valid: true }



Wings.Import.insert = (description = null, provider = null, importCode  = null, warehouse = null)->
  newImport = {}
  newImport.description = description if description
  newImport.provider    = provider if provider
  newImport.importCode  = importCode if importCode
  newImport.warehouse   = warehouse if warehouse

  validation = Wings.Import.isValidImport(newImport)
  if !validation.valid
    console.log validation.message
    return

  importId = Model.Import.insert(newImport)

Wings.Import.updateDescription = (description, importId)->
  validation = Wings.Import.isValidDescription(description, importId)
  if !validation.valid
    console.log validation.message
    return

  Model.Import.update importId, $set: {description: description}

Wings.Import.updateProvider = (providerId, importId)->
  validation = Wings.Import.isValidProvider(description, importId)
  if !validation.valid
    console.log validation.message
    return

  Model.Import.update importId, $set: {provider: providerId}

Wings.Import.remove = (importId)->
  validation = Wings.Import.isValidRemove(importId)
  if !validation.valid
    console.log validation.message
    return

  Model.Import.remove importId