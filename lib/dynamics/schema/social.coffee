Module 'Model',
  Message       : new Meteor.Collection 'messages'        , transform: (doc) -> doc
  Channel       : new Meteor.Collection 'channels'        , transform: (doc) -> doc
  News          : new Meteor.Collection 'news'            , transform: (doc) -> doc