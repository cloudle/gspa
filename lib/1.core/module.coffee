moduleKeywords = ['extended', 'included']

class @Module
  @extends: (objects...) ->
    for obj in objects
      @[key] = value for key, value of obj when key not in moduleKeywords
      obj.extended?.apply(@)
    this
  @include: (objects...) ->
    for obj in objects
      @::[key] = value for key, value of obj when key not in moduleKeywords
      obj.extended?.apply(@)
    this