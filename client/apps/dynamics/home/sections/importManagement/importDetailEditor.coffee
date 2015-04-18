Wings.defineWidget 'importDetailEditor',
  created: ->

  events:
    "keyup input.editQuality": (event, template) ->
      if event.which is 13
        Session.set("importsEditingRowId")
      else
        @quality = Convert.toNumber(template.find('.editQuality').value)
        console.log @update('quality')


    "keyup input.editPrice": (event, template) ->
      if event.which is 13
        Session.set("importsEditingRowId")
      else
        @price = Convert.toNumber(template.find('.editPrice').value)
        console.log @update('price')