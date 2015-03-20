Warehouse = Wings.Warehouse

Warehouse.insert = (name, description)->
#  if Meteor.userId() and name
#    if Wings.Warehouse.allowInsert()
#      Model.Warehouse.insert({name: name})

Warehouse.update = (option, warehouseId)->
  if Meteor.userId()
    if warehouse = Model.Warehouse.findOne()
      if Wings.Warehouse.allowUpdate()
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

        Model.Warehouse.update warehouse._id, $set: optionUpdate if _.keys(optionUpdate).length > 0


Warehouse.remove = (warehouseId)->
#  if Meteor.userId() and warehouseId
#      if Wings.Warehouse.allowRemove()
#        Model.Warehouse.remove warehouseId