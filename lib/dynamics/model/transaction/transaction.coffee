Wings.Enum.transactionGroups =
  sale          : 1
  import        : 2
  returnSale    : 3
  returnImport  : 4

class Model.Transaction
  constructor: (doc) -> @[key] = value for key, value of doc

  @insert: (group, parent, receivable, transactionAmount, description, debtDay, dueDay)->
    Meteor.call 'insertTransaction', group, parent, owner, receivable, totalCash, description, debtDay, dueDay,
      (err, result) -> console.log result

  insert: ()->
    self = @
    return {valid: false, error: 'This record is created'} if @_id
    Meteor.call 'insertTransaction', @group, @parent, @receivable, @transactionAmount, @description, @debtDay, @dueDay,
      (err, result) -> if result.valid then self._id = result.result; console.log result

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id
    Meteor.call 'updateTransaction', @_id, @, fields, (err, result) -> console.log result

  remove: ->
    return {valid: false, error: 'This _id is required!'} if !@_id
    Meteor.call 'removeTransaction', @_id, (err, result) -> console.log err, result