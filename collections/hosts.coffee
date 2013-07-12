self = @
###

  host     :  String
  hash     :  String
  css      :  string

###

@hosts = new Meteor.Collection 'hosts'

@hosts.allow
  insert: (userId, doc)->
    true
  update:(userId, docs, fields, modifier)->
    true if docs.owner is userId
  remove:  (userId, docs)->
    true if docs.owner is userId


if Meteor.isServer
  Meteor.publish "hosts", ->
    self.hosts.find()