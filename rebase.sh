# 1. Make executable
# chmod +x rebase.sh
# 2. Make an alias to run the script
# Add this in your .bashrc or zshrc
# alias rebase='/home/<full path to script>/rebase.sh'

#!/bin/sh

CURRENT_BRANCH=$(git symbolic-ref --short HEAD)
BASE_BRANCH="main"

if [ -z "$1" ]
    then
        BASE_BRANCH="main"
        git checkout main
    else
        BASE_BRANCH=$1
fi
git checkout $BASE_BRANCH
git pull
git checkout $CURRENT_BRANCH
git rebase $BASE_BRANCH
