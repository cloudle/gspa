Template.registerHelper 'currentUser', -> Meteor.user()

Template.registerHelper 'isEmptyCollection', (collection) -> return collection.count() is 0
Template.registerHelper 'nodeDetails', -> Schema.ApiNode.findOne(@toString())
Template.registerHelper 'nodeActiveClass', -> if @._id is Session.get("currentApiNode")?._id then 'active' else ''
Template.registerHelper 'renderNodeLeaves', -> !Session.get("apiTreeCollapse") and @._id is Session.get("currentApiNode")?._id and Schema.ApiMachineLeaf.find({parent: Session.get('currentApiNode')?._id}).count() > 0
Template.registerHelper 'renderNodeChilds', -> @parent != undefined or (!Session.get("apiTreeCollapse") and Session.get('currentApiRoot')?._id is @_id and @childNodes)

Template.registerHelper 'machineMethods', -> Schema.ApiMachineLeaf.find {parent: Session.get('currentApiNode')?._id, leafType: Wings.Enum.nodeTypes.method}
Template.registerHelper 'machineMembers', -> Schema.ApiMachineLeaf.find {parent: Session.get('currentApiNode')?._id, leafType: Wings.Enum.nodeTypes.property}

Template.registerHelper 'booleanDisplayClass', (visibility) -> if visibility then '' else 'hide'
Template.registerHelper 'booleanHideClass', (visibility) -> if visibility then 'hide' else ''

Template.registerHelper 'reactiveVar', (source) -> source?.get()
Template.registerHelper 'brackets', (source) -> "{#{source}}"
Template.registerHelper 'formatHour', (source) -> moment(source).format('h:mm a')

Template.registerHelper 'staffDisplayName', -> @profile?.name ? @username
