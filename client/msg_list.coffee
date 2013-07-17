self = @

o = (i)->
  if i < 10
    "0" + i
  else
    i


Template.msgList.helpers
  'date':->
    date = new Date(@time)
    [
      o date.getDate()
      '-'
      o date.getMonth() + 1
      '-'
      date.getFullYear()
      ' '
      o date.getHours()
      ':'
      o date.getMinutes()
      ].join('')
    # @time
  'user':->
    'anonymous' if @owner is 'anonymous'

  'owner': ->
    'owner' if Meteor.userId() and @owner is Meteor.userId()
    'owner' unless Meteor.userId() and @owner is 'anonymous'


Template.msgList.rendered= ->
  # move cursor to bottom
  el = document.getElementById('msgList')
  el.scrollTop = el.scrollHeight

Template.msgList.msgs = ->
  Meteor.subscribe "msgs", Session.get  'chatId'
  self.msgs.find()
  # , sort:time:-1
