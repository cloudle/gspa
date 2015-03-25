Model.Return.before.insert (userId, returnObj) ->
  returnObj.createdAt = new Date()

Model.Return.before.update (userId, returnObj, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.Return.allow
  insert: (userId, returnObj)-> true
  update: (userId, returnObj, fieldNames, modifier)-> true
  remove: (userId, returnObj)-> true