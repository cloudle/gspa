Sale = Wings.Sale

Sale.insertSale = (seller, buyer = null, saleCode  = null)->
  if Meteor.userId() and seller
    Model.Sale.insert({seller: seller, buyer: buyer, saleCode: saleCode})

Sale.updateSale = (option, priceId)->
  if Meteor.userId() and typeof option is 'object'
    if product = Model.Sale.findOne(priceId)
      optionUpdate = {}

      if option.name
        if typeof option.name is 'string' and option.name.length > 0
          optionUpdate.name = option.name
        else
          console.log 'name is error'

      if option.description
        if typeof option.description is 'string'
          optionUpdate.description = option.description
        else

      if option.image
        if typeof option.image is 'string'
          optionUpdate.image = option.image
        else

      Model.Sale.update product._id, $set: optionUpdate if _.keys(optionUpdate).length > 0

Sale.removeSale = (priceId)->
  if Meteor.userId() and priceId
    Model.Sale.remove priceId