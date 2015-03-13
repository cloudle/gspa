Wings.Validate = {}

Wings.Validate.createAccount = (option)->
  userOption = {}
  result = {error: true, message:null, detail: null}

  if typeof option is 'object'
    userOption.username = option.username if typeof option.username is 'string'
    userOption.email    = option.email if typeof option.email is 'string'
    userOption.password = option.password if typeof option.password is 'string'

    if (userOption.username or userOption.email) and userOption.password
      if userOption.username and !userOption.email
        result.message = "username is length < 10" if userOption.username.length < 10

      if userOption.email and !userOption.username
        result.message = "email is length < 10" if userOption.email.length < 10

      if userOption.password and userOption.password.length < 10
        result.message = "password is length > 10"

      result.error = false; result.detail = userOption

    else if userOption.password
      result.message = "username or email is empty"

    else if userOption.username or userOption.email
      result.message = "password is empty"

    else
      result.message = "option is empty 1"

  else
    result.message = "option is undefined"

  return result
