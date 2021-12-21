#!/bin/bash
while true; do
    read -r -p "This will delete every local branch. Continue? [y/n]" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
git checkout master
git branch | grep -v ' master$' | xargs -r git branch -D
git remote prune origin
git prune
git gc
