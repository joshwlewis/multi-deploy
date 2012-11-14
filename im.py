#!/usr/bin/python
import sys, dbus, gobject;
bus = dbus.SessionBus()
obj = bus.get_object("im.pidgin.purple.PurpleService", "/im/pidgin/purple/PurpleObject")
purple = dbus.Interface(obj, "im.pidgin.purple.PurpleInterface")
for conv in purple.PurpleGetIms():
  user = purple.PurpleConversationGetName(conv)
  if len(sys.argv) == 1:
    print user
  elif user == sys.argv[1]:
    purple.PurpleConvImSend(purple.PurpleConvIm(conv), sys.argv[2])
    print 'Sending "'+sys.argv[2]+'" to '+sys.argv[1]
