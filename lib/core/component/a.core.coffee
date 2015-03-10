mappingExceptions = ['ui', 'rendered']

Wings.Component.invokeIfNecessary = (method, context) -> method.apply(context, arguments) if method
Wings.Component.cloneTemplateEssential = (source, destination) ->
  source[name] = value for name, value of destination when !_(mappingExceptions).contains(name)

Wings.Component.customBinding = (uiOptions, context) ->
  context.ui = {}
  context.ui[name] = context.find(value) for name, value of uiOptions when typeof value is 'string'

Wings.Component.autoBinding = (context) ->
  context.ui = context.ui ? {}
  Wings.Component.bindingElements(context)

Wings.Component.bindingElements = (context) ->
  for item in context.findAll("[name]:not([binding])")
    name = $(item).attr('name')
    context.ui[name] = item
    context.ui["$#{name}"] = $(item)

#-------------------------------------------------------------
bindingToolTip = (context) -> $("[data-toggle='tooltip']").tooltip({container: 'body'})