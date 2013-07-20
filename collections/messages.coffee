self = @
###

  text     :  String
  chat     :  id

###

@chats = new Meteor.Collection 'chats'
@msgs = new Meteor.Collection 'msgs'

@msgs.allow
  insert: (userId, doc)->
    true
  update:(userId, docs, fields, modifier)->
    true if docs.owner is userId
  remove:  (userId, docs)->
    true if docs.owner is userId

@chats.allow
  insert: (userId, doc)->
    true
  update:(userId, docs, fields, modifier)->
    true
  remove:  (userId, docs)->
    false

if Meteor.isServer
  Meteor.publish "msgs", (chatId)->
    self.msgs.find {chatId:chatId}


  Meteor.publish "chats", ->
    self.chats.find()