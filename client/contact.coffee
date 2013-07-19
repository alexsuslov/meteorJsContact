self = @

Template.contact.helpers
  'user':->
    true unless Meteor.userId()
  'img':->
    Session.get 'oprImg'
  'name':->
    Session.get 'oprName'
  'info':->
    Session.get 'oprInfo'
  'userName':->
    Session.get 'userName'

addMsg = ( text, owner)->
  # subscribe
  Meteor.subscribe "chats"
  Meteor.subscribe "msgs"

  # проверка на сущ. чата
  chatId = Session.get  'chatId'
  unless chatId
    # новый чат
    chat =
      online: new Date().getTime()
    # Добавляем имя клиента если есть
    userName = Session.get 'userName'
    chat.userName = userName if userName
    # делаем новый чат
    chatId = self.chats.insert chat
    Session.set 'chatId', chatId
  # сообщение
  owner = 'anonymous' unless owner
  msg =
    owner:owner
    text: text
    chatId:chatId
    time: new Date().getTime()
  # добавляем сообщение в чат
  lastMsg = self.msgs.insert msg
  if lastMsg
    Session.set 'lastMsg', lastMsg
    $('textarea#msg').val('')


Template.contact.events
  'keyup input#name':(e)->
    value = e.target.value.replace(/\n|^\s+|\s+$/g,'')
    if e.keyCode is 13 and value
      addMsg 'Здраствуйте, ' + e.target.value + '.' , 'system'
      Session.set 'userName', e.target.value

  'keyup textarea#msg':(e)->
    value = e.target.value.replace(/\n|^\s+|\s+$/g,'')
    # console.log e.keyCode
    if e.keyCode is 38
      # console.log 'keyup'
      if Session.get 'lastMsg'
        msg = self.msgs.findOne Session.get 'lastMsg'
        $(e.target).val msg.text if msg?.text
    if e.keyCode is 13 and value and !e.altKey
      addMsg value

