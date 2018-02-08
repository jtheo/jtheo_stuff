#!/bin/bash
# Idea from https://stackoverflow.com/a/501461
# Thanks Mipadi! https://stackoverflow.com/users/28804/mipadi

function help(){
    cat << EOF

    Help $0
    Syntax: $0 <branch> [debug]
    ex:
    $0 feat_branch_1
    or:
    $0 other_branch_2 verbose
    To have a more git diff
EOF
}

if [[ -z $1 ]]
then
    Check_Branch_Exist=$(git rev-parse --verify $1 2> /dev/null)
    if [[ ${Check_Branch_Exist} -eq 0 ]]
    then
        BRANCH=$1
    else
        echo "The branch you tried ($1) doesn't exist"
        help
        exit
    fi
else
    help
    exit 1
fi

VERBOSE=$2

git merge --no-commit --no-ff ${BRANCH}

if [[ -z ${VERBOSE} ]]
then
    git diff --cached
else
    git status
fi

git merge --abort