#!/usr/bin/env bash

current_date_time=$(date "+%Y-%m-%d %H:%M:%S")

git add .
git commit -m "$current_date_time"

git checkout backups
git merge main

git add .
git commit -m "$current_date_time"
git push origin backups

git checkout main

git stash apply

echo $?