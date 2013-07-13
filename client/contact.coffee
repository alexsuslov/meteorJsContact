self = @

Template.contact.helpers
  'img':->
    Session.get 'oprImg'
  'name':->
    Session.get 'oprName'
  'info':->
    Session.get 'oprInfo'