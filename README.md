multi-deploy
============

Crude script for deploying multiple capistrano deployable projects

Usage
-----

sh multideploy.sh [-e [environment]][-b [branch]][-m][-i [im-user]]

OPTIONS:
  * -h   This message
  * -e   Target rails environment [development, production]
  * -b   Git remote branch to deploy [master, cool_feature]
  * -m   Run migrations
  * -i   IM user to notify, optional (requires open pidgin conversation with target)