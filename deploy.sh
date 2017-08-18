
#!/bin/bash
if [ -z "$1" ]
  then
    echo "First argument, remote_name, not provided"
    echo "Please run the script as deploy.sh <remote_name> <heroku_app_name>"
    exit
fi

if [ -z "$2" ]
  then
    echo "Second argument, heroku_app_name, not provided"
    echo "Please run the script as deploy.sh <remote_name> <heroku_app_name>"
    exit
fi

remote_name=$1
app_name=$2

current_branch="$(git rev-parse --abbrev-ref HEAD)"
git push -f $remote_name $current_branch:master
heroku run rake db:migrate --app $app_name
heroku restart --app $app_name
echo "Deploy FINISHED!"