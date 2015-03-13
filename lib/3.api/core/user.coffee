Wings.User = {}

Wings.User.insert = (option)->
  result = Wings.Validate.createAccount(option)
  if result.error then result
  else
    Meteor.call 'createNewUser', result.detail, (error, userId)->
      if error then console.log error
      else console.log userId

Wings.User.remove = (userId)->
  Meteor.users.remove userId if Meteor.userId() and Meteor.userId() isnt userId

Wings.User.update = (option, userId)->
  if Meteor.userId() and typeof option is 'object'
    if userProfile = Model.UserProfile.findOne({account: userId ? Meteor.userId()})
      if Wings.Account.allowUpdate()
        profileUpdate = {}

        if option.name
          if typeof option.name is 'string' and option.name.length > 0
            profileUpdate.name = option.name
          else
            console.log 'name is error'

        if option.roles
          if Array.isArray(option.roles) and option.roles.length > 0
            profileUpdate.roles = option.roles
          else

        if option.gender
          if typeof option.gender is 'boolean'
            profileUpdate.gender = option.gender
          else if typeof option.gender is 'string'
            profileUpdate.gender = true if option.gender is 'nam'
            profileUpdate.gender = false if option.gender is 'nu'
          else

        if option.description
          if typeof option.description is 'string'
            profileUpdate.description = option.description
          else

        if option.salaryBasic
          salary = parseInt(option.salaryBasic)
          if !isNaN(salary) and salary > 0
            profileUpdate.salaryBasic = salary
          else

        if option.address
          if typeof option.address is 'string'
            profileUpdate.address = option.address
          else

        if option.image
          if typeof option.image is 'string'
            profileUpdate.image = option.image
          else

        if option.startWorkingDate
          profileUpdate.startWorkingDate = option.startWorkingDate

        if option.dateOfBirth
          profileUpdate.dateOfBirth = option.dateOfBirth

        Model.UserProfile.update userProfile._id, $set: profileUpdate if _.keys(profileUpdate).length > 0