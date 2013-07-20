self = @

Meteor.methods
  'operator': (chatId)->
    unless Meteor.users.findOne({"profile.online": true, "role.operator" : 1})
      msg =
        owner:'system'
        text: 'Оператор не доступен. Укажите ваш телефон (Email) и удобное для вас время.'
        chatId:chatId
        time: new Date().getTime()
      # добавляем сообщение в чат
      self.msgs.insert msg

Meteor.startup ()->

