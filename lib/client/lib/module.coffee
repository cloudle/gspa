#Init
#Destroy
#Tải dữ liệu độc lập
#Các loại events,
#Giao tiếp với Template và các Modules khác

Module "Wings",
  moduleInstances: {}
  events: new EventEmitter()
  register: (moduleId, dependencies..., creator) ->
    @moduleInstances[moduleId] =
      creator: creator
      instance: null

    return moduleId

  start: (moduleId) ->
    (console.log "Module #{moduleId} not found."; return) if !module = @moduleInstances[moduleId]
    module.instance = module.creator(@sandbox())
    module.instance.init()

  stop: (moduleId) ->
    (console.log "Module #{moduleId} not found."; return) if !module = @moduleInstances[moduleId]
    (module.instance.destroy(); module.instance = null) if module.instance

  startModule: ->
  stopModule: ->

Wings.events.on "testInitialized", (data) -> console.log data.message