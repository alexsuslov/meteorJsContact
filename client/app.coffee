self = @
Session.set 'oprImg', '/img/op.jpg'
Session.set 'oprName', 'testName'
Session.set 'oprInfo', 'testInfo'


Meteor.startup ->
  Meteor.subscribe "chats"
  chatId = self.getCookie 'contact'
  if chatId
    Session.set 'chatId', chatId

  interval = 10 * 1000
  # set chat online status
  Meteor.setInterval ()->
    chatId = Session.get 'chatId'
    if chatId
      update=
        online: new Date().getTime()
      self.chats.update chatId, $set:update
  , interval

