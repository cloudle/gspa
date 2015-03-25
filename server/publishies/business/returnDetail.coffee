Model.ReturnDetail.before.insert (userId, returnDetail) ->
  returnDetail.creator = userId if userId
  returnDetail.createdAt = new Date()

Model.ReturnDetail.before.update (userId, returnDetail, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.ReturnDetail.allow
  insert: (userId, returnDetail)-> true
  update: (userId, returnDetail, fieldNames, modifier)-> true
  remove: (userId, returnDetail)-> true