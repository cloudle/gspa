interfaceKeywords = ['constructor', 'static']

@Interface = (namespace, specifications) ->
#  currentNamespace = @
#  namespaceParts = namespace.split(".")
#  for part in namespaceParts
#    previousNamespace = currentNamespace; lastPart = part
#    currentNamespace[part] = {} if !currentNamespace[part]
#    currentNamespace = currentNamespace[part]
  namespace = generateNamespace(namespace)

  namespace.parent = specifications.constructor ? ->
  namespace::[key] = value for key, value of specifications when key not in interfaceKeywords
  namespace[key] = value for key, value of specifications.static if specifications.static

#  previousNamespace[lastPart] = specifications.constructor ? ->
#  previousNamespace[lastPart]::[key] = value for key, value of specifications when key not in moduleKeywords
#  previousNamespace[lastPart][key] = value for key, value of specifications.static if specifications.static

@Module = (namespace, specifications) ->
  namespace = generateNamespace(namespace)
  namespace[key] = value for key, value of specifications

generateNamespace = (namespace) ->
  currentNamespace = @
  namespaceParts = namespace.split(".")
  for part in namespaceParts
    previousNamespace = currentNamespace; lastPart = part
    currentNamespace[part] = {} if !currentNamespace[part]
    currentNamespace = currentNamespace[part]
  previousNamespace[lastPart]