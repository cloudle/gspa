Schema.Customer.before.insert (userId, doc) ->
  doc.creator = userId if userId
  doc.createdAt = new Date()

Schema.Customer.before.update (userId, doc, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Schema.Customer.allow
  insert: (userId, customer)-> true
  update: (userId, customer, fieldNames, modifier)-> true
  remove: (userId, customer)-> true

#Meteor.publish 'customer', () ->
#  self = @
#  initializing = true
#
#  groups = Schema.CustomerGroup.find()
#  customers = Schema.Customer.find()
#
#  handle = groups.observeChanges
#    changed: (id, fields)->
#      customer = Schema.Customer.findOne({group: id})
#      if (!initializing) and customer
#        self.changed("customers", customer._id, {groupName: fields.name}) if fields.name
#
#  self.ready()
#  initializing = false
#  self.onStop () -> handle.stop()
#
#  [groups, customers]