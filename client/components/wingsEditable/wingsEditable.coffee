simulateModel = (context, template) ->
  simulatedModel = _(context.model).clone()
  simulatedModel[context.field] = $(template.find("[field='#{context.field}']")).val()
  return simulatedModel

Wings.defineWidget 'wingsEditable',
  fieldValue: -> @model?[@field]
  saveRemainingClass: -> if Template.instance().saveRemaining.get() then 'save-remaining' else ''
  activeClass: -> if Template.instance().hasFocus.get() then 'active' else ''

  created: ->
    Template.instance().saveRemaining = new ReactiveVar(false)
    Template.instance().hasFocus = new ReactiveVar(false)

  events:
    "keyup input": (event, template) ->
      if event.which is 13
        model = simulateModel(@, template)
        updateResult = Wings.CRUD.updateField(Model.ApiNode, model, @field, Wings.validatorTest)
        Template.instance().saveRemaining.set(!updateResult.valid)
      else if event.which is 27
        $(event.currentTarget).val(@model[@field])
        Template.instance().saveRemaining.set(false)

    "input input": (event, template) ->
      hasChange = @model[@field] isnt $(event.currentTarget).val()
      Template.instance().saveRemaining.set(hasChange)
    "focus input": -> Template.instance().hasFocus.set(true)
    "blur input": -> Template.instance().hasFocus.set(false)