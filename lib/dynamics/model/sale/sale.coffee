Wings.Enum.salePaymentsDeliveries =
  direct : 1
  order  : 2

Wings.Enum.salePaymentMethods =
  cash  : 1
  debit : 2

class Model.Sale
  constructor: (doc) -> @[key] = value for key, value of doc

  @insert: (description = null, buyerId = null, sellerId = null)->
    Meteor.call 'insertSale', description, buyerId, sellerId, (err, result) -> console.log result

  insert: ->
    self = @
    return {valid: false, error: 'This record is created'} if @_id
    Meteor.call 'insertSale', @description, @buyer, @seller,
      (err, result) -> if result.valid then self._id = result.result; console.log result

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id
    Meteor.call 'updateSale', @_id, @, fields, (err, result) -> console.log result

  remove: ->
    return {valid: false, error: 'This _id is required!'} if !@_id
    Meteor.call 'removeSaleDetail', @_id, (err, result) -> console.log err, result


  insertDetail: (branchPriceId, quality, price)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    quality = Convert.toNumber(quality)
    price   = Convert.toNumber(price)
    Meteor.call 'insertSaleDetail', @_id, branchPriceId, quality, price, (err, result) -> console.log result

  submitSale: ->
    return {valid: false, error: 'This _id is required!'} if !sale = Schema.Sale.findOne @_id
    return {valid: false, error: 'This Import is Submit!'} if sale.status is "submit"

    Meteor.call 'submitSale', @_id, (err, result) -> console.log result