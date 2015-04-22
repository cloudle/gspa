scope = logics.home = {}

Wings.Router.add
  template: 'home'
  path: '/'
  onBeforeAction: ->
    if @ready()
      Wings.Router.setup(scope, setups.homeInits, "home")
      @next()
  data: ->
    Wings.Router.setup(scope, setups.homeReactives)

    return {
    }