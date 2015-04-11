Module 'Model',
  Notification    : new Meteor.Collection 'notifications'
  Role            : new Meteor.Collection 'roles'

  Account         : Meteor.users
  UserOption      : new Meteor.Collection 'userOptions'
  UserProfile     : new Meteor.Collection 'userProfiles'
  UserSession     : new Meteor.Collection 'userSessions'