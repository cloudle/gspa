goldenRatio = 1.618
Wings.Design = {}

Wings.Design.goldenBaseSize = (fullSize) -> fullSize / goldenRatio
Wings.Design.goldenAddOnSize = (baseSize) -> baseSize / goldenRatio
Wings.Design.goldenFullSize = (baseSize) -> baseSize * goldenRatio
Wings.Design.goldenSplit = (fullSize) ->
  baseSize = Wings.Design.goldenBaseSize(fullSize)
  addOnSize = Wings.Design.goldenAddOnSize(baseSize)
  return { base: baseSize, addOn: addOnSize}

#------------------------------------------------------------------
safeSessions = []

Wings.listSession = -> console.log key for key, obj of Session.keys
Wings.cleanSession = ->
  console.log 'cleaning sessions'
  delete Session.keys[key] for key, obj of Session.keys when !_.contains(safeSessions, key)

Wings.logout = (redirectUrl = '/')->
  Meteor.logout()
  Wings.setupHistories = []
  Wings.cleanSession()
  Meteor.setTimeout ->
    Router.go(redirectUrl) if redirectUrl
  , 1000