Model.Provider.before.insert (userId, provider) ->
  provider.creator = userId if userId
  provider.createdAt = new Date()

Model.Provider.before.update (userId, provider, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.Provider.after.remove (userId, provider) ->
  Model.Import.find({provider: provider._id}).forEach(
    (currentImport) ->
      Model.Import.remove(currentImport._id)
      Model.ImportDetail.remove({import: currentImport._id})
  )


Model.Provider.allow
  insert: (userId, provider)-> true
  update: (userId, provider, fieldNames, modifier)-> true
  remove: (userId, provider)-> true