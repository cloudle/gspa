Wings.defineApp 'apiNode',
  nodeDetails: ->
    console.log Model, @
#    console.log Model.ApiNode.findOne()
    Model.ApiNode.findOne(@toString())
#    return {name: "cloud"}
