multi-deploy
============

Crude script for deploying multiple projects with capistrano

Usage:

sh multideploy.sh [-e [environment]][-b [branch]][-m][-i [im-user]]

Use this script to deploy multiple capistrano deployable projects to desired environment.

OPTIONS:
  -h   This message
  -e   Target rails environment [development, production]
  -b   Git remote branch to deploy [master, cool_feature]
  -m   Run migrations
  -i   IM user to notify, optional (requires open pidgin conversation with target)