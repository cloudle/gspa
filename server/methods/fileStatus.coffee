fs = Meteor.npmRequire('fs')
read = Meteor.npmRequire('node-read')

Meteor.methods
  listServerFiles: -> Meteor.wrapAsync(fs.readdir)('/')
  readSite: (url) -> Meteor.wrapAsync(read)(url)