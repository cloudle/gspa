Wings.defineApp = (source, destination) ->
  if typeof source is 'string'
    console.log "You're trying defines a not exists template" if !Template[source]
    source = Template[source]

  Wings.Component.cloneTemplateEssential(source, destination)

  source.rendered = ->
    Wings.Component.customBinding(destination.ui, @) if destination.ui
    Wings.Component.autoBinding(@)
    Wings.Component.invokeIfNecessary(destination.rendered, @)

Wings.defineWidget = (source, destination) ->
  Wings.Component.cloneTemplateEssential(source, destination)

  source.rendered = ->
    Wings.Component.customBinding(destination.ui, @) if destination.ui
    Wings.Component.invokeIfNecessary(destination.rendered, @)