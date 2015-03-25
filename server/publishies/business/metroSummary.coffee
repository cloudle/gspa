Model.MetroSummary.before.insert (userId, metroSummary) ->
  metroSummary.creator = userId if userId
  metroSummary.createdAt = new Date()

Model.MetroSummary.before.update (userId, metroSummary, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.MetroSummary.allow
  insert: (userId, metroSummary)-> true
  update: (userId, metroSummary, fieldNames, modifier)-> true
  remove: (userId, metroSummary)-> true