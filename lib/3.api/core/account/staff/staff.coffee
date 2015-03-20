Staff = Wings.Account.Staff = {}

Staff.insert = (staffObj)->
  result = createAccount(staffObj)
  if result.error then result
  else
    Meteor.call 'createNewAccount', result.detail, (error, userId)->
      if error then console.log error
      else console.log userId

Staff.update = (option, userId)->
  if Meteor.userId() and typeof option is 'object'
    if userProfile = Model.UserProfile.findOne({user: userId ? Meteor.userId()})
      optionUpdate = {}

      if option.name
        if typeof option.name is 'string' and option.name.length > 0
          optionUpdate.name = option.name
        else
          console.log 'name is error'

      if option.roles
        if Array.isArray(option.roles) and option.roles.length > 0
          optionUpdate.roles = option.roles
        else

      if option.gender
        if typeof option.gender is 'boolean'
          optionUpdate.gender = option.gender
        else if typeof option.gender is 'string'
          optionUpdate.gender = true if option.gender is 'nam'
          optionUpdate.gender = false if option.gender is 'nu'
        else

      if option.description
        if typeof option.description is 'string'
          optionUpdate.description = option.description
        else

      if option.salaryBasic
        salary = parseInt(option.salaryBasic)
        if !isNaN(salary) and salary > 0
          optionUpdate.salaryBasic = salary
        else

      if option.address
        if typeof option.address is 'string'
          optionUpdate.address = option.address
        else

      if option.image
        if typeof option.image is 'string'
          optionUpdate.image = option.image
        else

      if option.startWorkingDate
        optionUpdate.startWorkingDate = option.startWorkingDate

      if option.dateOfBirth
        optionUpdate.dateOfBirth = option.dateOfBirth

      Model.UserProfile.update userProfile._id, $set: optionUpdate if _.keys(optionUpdate).length > 0

Staff.remove = (staffId)->
  Model.Account.remove staffId if Meteor.userId() and Meteor.userId() isnt staffId


createAccount = (option)->
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