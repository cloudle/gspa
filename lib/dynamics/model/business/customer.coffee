Model.Customer = new Meteor.Collection 'customers',
  transform: (doc)->
    (doc.groupName = Model.CustomerGroup.findOne(doc.group)?.name) if doc.group
    return doc