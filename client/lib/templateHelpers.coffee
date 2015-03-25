Template.registerHelper 'isEmptyCollection', (collection) -> return collection.count() is 0
Template.registerHelper 'nodeDetails', -> Model.ApiNode.findOne(@toString())
Template.registerHelper 'nodeActiveClass', -> if @._id is Session.get("currentApiNode")?._id then 'active' else ''
Template.registerHelper 'renderNodeLeaves', -> @._id is Session.get("currentApiNode")?._id and Model.ApiMachineLeaf.find({parent: Session.get('currentApiNode')?._id}).count() > 0

Template.registerHelper 'machineMethods', -> Model.ApiMachineLeaf.find {parent: Session.get('currentApiNode')?._id, leafType: Wings.Enum.nodeTypes.method}
Template.registerHelper 'machineMembers', -> Model.ApiMachineLeaf.find {parent: Session.get('currentApiNode')?._id, leafType: Wings.Enum.nodeTypes.property}


Template.registerHelper 'booleanDisplayClass', (visibility) -> if visibility then '' else 'hide'
Template.registerHelper 'booleanHideClass', (visibility) -> if visibility then 'hide' else ''

Template.registerHelper 'reactiveVar', (source) -> source?.get()