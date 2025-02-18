# Adds branch name to commit message
# if your branch name is sc-xxxxx the commit message
# would start with [sc-xxxxx]
# Add to ~/.git-templates/hooks/prepare-commit-msg
# run `git init` in your projects
# run chmod to make it executable
# chmod +x .git/hooks/prepare-commit-msg

#!/bin/sh

COMMIT_MSG_FILE=$(echo $1 | head -n1 | cut -d " " -f1)

if [ -z "$BRANCHES_TO_SKIP" ]; then
 BRANCHES_TO_SKIP=(master main)
fi

BRANCH_NAME=$(git symbolic-ref --short HEAD)
BRANCH_NAME="${BRANCH_NAME##*/}"

BRANCH_EXCLUDED=$(printf "%s\n" "${BRANCHES_TO_SKIP[@]}" | grep -c "^$BRANCH_NAME$")
BRANCH_IN_COMMIT_MSG=$(head -1 $COMMIT_MSG_FILE | grep -c "$BRANCH_NAME")

if [ -n "$BRANCH_NAME" ] && ! [[ $BRANCH_EXCLUDED -eq 1 ]] && ! [[ $BRANCH_IN_COMMIT_MSG -ge 1 ]]; then 
 sed -i'.bak' -e "1s/^/[$BRANCH_NAME] /" $COMMIT_MSG_FILE
fi