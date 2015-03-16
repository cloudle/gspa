Template.registerHelper 'nodeDetails', -> Model.ApiNode.findOne(@toString())
Template.registerHelper 'nodeActiveClass', -> if @._id is Session.get("currentApiNode")?._id then 'active' else ''