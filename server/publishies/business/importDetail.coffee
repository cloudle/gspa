Model.ImportDetail.before.insert (userId, importDetail) ->
  importDetail.creator = userId if userId
  importDetail.createdAt = new Date()

Model.ImportDetail.before.update (userId, importDetail, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.ImportDetail.allow
  insert: (userId, importDetail)-> true
  update: (userId, importDetail, fieldNames, modifier)-> true
  remove: (userId, importDetail)-> true