Wings.Sale = {}
Wings.Sale.nextCode = ()-> null
Wings.Sale.changStatus = ()-> null

Wings.Sale.insert = (seller, buyer = null, saleCode  = null)->
  if Meteor.userId() and seller
    if Wings.Sale.allowInsert()
      Model.Sale.insert({seller: seller, buyer: buyer, saleCode: saleCode})

Wings.Sale.update = (option, priceId)->
  if Meteor.userId() and typeof option is 'object'
    if product = Model.Sale.findOne(priceId)
      if Wings.Sale.allowUpdate(priceId)
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

Wings.Sale.remove = (priceId)->
  if Meteor.userId() and priceId
    if Wings.Sale.allowRemove(priceId)
      Model.Sale.remove priceId