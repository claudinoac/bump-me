#!/bin/bash
echo "INFO: Package version will be updated. Updating..."
if [[ "$PR_TITLE" =~ .*"feat:".* ]]; then
    bump --minor --reset
else
    bump --patch
fi
NEW_TAG=$(cat setup.py | grep -o [0-9].[0-9].[0-9])
git config --global user.name "Github Actions"
git config --global user.email "github-actions@github.com"
git config --unset 'http.https://github.com/.extraHeader'
git remote set-url origin "https://claudinoac:$BUMPER_TOKEN@github.com/claudinoac/bump-me"
git add setup.py
git commit -m "chore: update package version to v$NEW_TAG"
git push -u
git tag -a v$NEW_TAG -m "Add tag to v$NEW_TAG"
git push origin --tags
echo "SUCCESS: Your package is updated!"


