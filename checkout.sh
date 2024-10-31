# 1. Make executable
# chmod +x checkout.sh
# 2. Make an alias to run the script
# Add this in your .bashrc or zshrc
# alias checkout='/home/<full path to script>/checkout.sh'

#!/bin/sh

if [ -z "$1" ]
    then
        echo "Usage: $0 ticketNumber [baseBranch]"
    else
        if [ -z "$2" ]
            then
                git checkout main
            else
                git checkout $2
        fi
        git pull
        git checkout -b sc-$1
fi
