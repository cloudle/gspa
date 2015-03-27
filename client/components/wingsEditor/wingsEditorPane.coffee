Wings.defineHyper 'wingsEditorPane',
  isEditingClass: -> if Wings.Editor.isActive.get() then 'active' else ''
  boldActiveClass: -> if Wings.Editor.commands.bold.isActive.get() then 'active' else ''
  italicActiveClass: -> if Wings.Editor.commands.italic.isActive.get() then 'active' else ''
#  underActiveClass: -> if Wings.Editor.commands.italic.isActive.get() then 'active' else ''
#  crossActiveClass: -> if Wings.Editor.commands.italic.isActive.get() then 'active' else ''
  events:
    "mousedown .button": (event, template) ->
      document.execCommand $(event.currentTarget).attr("action")
      event.stopPropagation()