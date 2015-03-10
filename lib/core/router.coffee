Wings.Router = {}
Wings.Router.routes = []

Wings.Router.Base =
  layoutTemplate: 'defaultLayout'
  loadingTemplate: 'silentLoadingLayout'
  onAfterAction: ->
    Wings.Helper.animateUsing("#container", 'fadeInDown')

Wings.Router.add = (routes, baseRoute = Wings.Router.Base) ->
  routes = [routes] unless Array.isArray(routes)
  for route in routes
    routeLayoutTemplate = route.layoutTemplate
    _.extend(route, baseRoute)
    route.layoutTemplate = routeLayoutTemplate if routeLayoutTemplate

    if route.waitOnDependency
      route.waitOn = ->
        results = Wings.Dependency.resolve(route.waitOnDependency)
        item.ready() for item in results
        results

    Wings.Router.routes.push route
  return

Wings.Router.buildRoutes = ->
  for route in Wings.Router.routes
    template = undefined

    if route.template and route.path
      template = route.template; delete route.template
    else if route.template
      template = route.template; delete route.template
      route.path = "/#{template}"
    else if route.path
      template = route.path.substring(1)

    Router.route template, route if template