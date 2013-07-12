self = @
###

  msgs     :  String
  owner    :  userId
  chat  :  id

###

@msgs = new Meteor.Collection 'msgs'

@msgs.allow
  insert: (userId, doc)->
    true
  update:(userId, docs, fields, modifier)->
    true if docs.owner is userId
  remove:  (userId, docs)->
    true if docs.owner is userId


if Meteor.isServer
  Meteor.publish "msgs", ->
    self.msgs.find()