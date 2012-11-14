#! /bin/bash

# deploys multiple sites to desired environment

usage()
{
cat<<EOF
usage: $0 options

Use this script to deploy multiple capistrano deployable projects to desired environment.

OPTIONS:
  -h   This message
  -e   Target rails environment [development, production]
  -b   Git remote branch to deploy [master, cool_feature]
  -m   Run migrations
  -i   IM user to notify, optional (requires open pidgin conversation with target)

EOF
}

# This is the list of sites to deploy, edit as needed
sites=( app1 app2 app3 )

# This is where your local repositories are stored, change as needed
work_dir=~/dev/rails/apps/


#these variales controlled by flags
environment=
branch=
migrations=
im_user=
im=false
sleep_time=90

while getopts "he:b:mi:" OPTION
do
  case $OPTION in
    h)
      usage
      exit 1
      ;;
    e)
      environment=$OPTARG
      ;;
    b)
      branch=$OPTARG
      ;;
    m)
      migrations=":migrations"
      ;;
    i)
      im_user=$OPTARG
      ;;
    ?)
      usage
      exit 1
      ;;
  esac
done

if [[ -z $environment ]]
then
  environment="production"
fi

if [[ -z $branch ]]
then
  branch="master"
fi

if [[ ! -z $im_user ]]
then
  im=true
fi


cd $work_dir

echo -n "Branch: $branch"
echo -n "Environment: $environment"
echo -n "IM User: $im_user"
echo -n "IM: $im"
if $im ; then
  python ~/.md/im.py $im_user "<p style='color: green'><b>--> Beginning multi-deploy to $environment</b></p>"
fi

for site in ${sites[@]}
do
  cd $site
  echo -ne "\e[00;36m{[deploying $site to $environment]}\n\e[00m"
  git reset --hard
  git co $branch
  git pull
  cap -s branch=$branch $environment deploy$migrations
  if $im ; then
    python ~/.md/im.py $im_user "<p style='color: purple'><b>--> $site deployed to $environment</b></p>"
  fi
  echo -ne "\e[00;32m{[$site deployed to $environment]}\n\e[00m"
  cd $work_dir
  echo -ne "Sleeping between sites....."
  sleep $sleep_time
done
if $im ; then
  python ~/.md/im.py $im_user "<p style='color: green'><b>--> Completed multi-deploy to $environment</b></p>"
fi