@userIP = (uid)->
  ret = {}
  if uid?
    s = ss for k, ss of Meteor.default_server.sessions when ss.userId is uid
    if s
      ret.forwardedFor = s.socket?.headers?['x-forwarded-for']
      ret.remoteAddress = s.socket?.remoteAddress
  ret