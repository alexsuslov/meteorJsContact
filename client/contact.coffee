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


Template.contact.events
  'keyup input#name':(e)->
    if e.keyCode is 13 and e.target.value
      Session.set 'userName', e.target.value

  'keyup textarea#msg':(e)->
    value = e.target.value.replace(/\n|^\s+|\s+$/g,'')
    # console.log e.keyCode
    if e.keyCode is 38
      # console.log 'keyup'
      if Session.get 'lastMsg'
        msg = self.msgs.findOne Session.get 'lastMsg'
        $(e.target).val msg.text if msg?.text
    if e.keyCode is 13 and value
      # subscribe
      Meteor.subscribe "chats"
      Meteor.subscribe "msgs"

      text = e.target.value
      # проверка на сущ. чата
      chatId = Session.get  'chatId'
      unless chatId
        # новый чат
        chat =
          online: new Date().getTime()
        # Добавляем имя клиента если есть
        userName = Session.get 'userName'
        chat.userName = userName if userName
        # Добавляем Id клиента если есть
        userId = Meteor.userId()
        chat.owner = userId if userId
        # делаем новый чат
        chatId = self.chats.insert chat
        Session.set 'chatId', chatId
      # сообщение
      if Meteor.userId()
        owner = Meteor.userId()
      else
        owner = 'anonymous'
      msg =
        owner:owner
        text: value
        chatId:chatId
        time: new Date().getTime()
      # добавляем сообщение в чат
      lastMsg = self.msgs.insert msg
      if lastMsg
        Session.set 'lastMsg', lastMsg
        $('textarea#msg').val('')
