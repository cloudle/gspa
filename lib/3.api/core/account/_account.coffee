Wings.Account = {}

Wings.Account.insert = (option)->
  newAccount = {password: option.password}
  newAccount.email    = option.email  if option.email
  newAccount.username = option.username if option.username

  if !newAccount.username and !newAccount.email or !newAccount.password
    if newAccount.password then console.log 'username or email is required' else console.log 'password is required'
    return {valid: false}

  isValidModel = Wings.CRUD.validate(newAccount, Wings.Validators.accountCreate)
  (console.log isValidModel.error; return isValidModel) unless isValidModel.valid

  Meteor.call 'createNewAccount', (error, userId)-> if error then console.log error else console.log userId


Wings.Account.update = (option, userId)->
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

Wings.Account.remove = (staffId)->
  Model.Wings.Account.remove staffId if Meteor.userId() and Meteor.userId() isnt staffId
