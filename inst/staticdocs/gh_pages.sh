#!/bin/bash

if [ "$TRAVIS_REPO_SLUG" == "${GH_REF}" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_BRANCH" == "master" ]; then

    cd inst/web/

    git config --global user.email "travis@travis-ci.org"
    git config --global user.name "travis-ci"

    git init -q .
    git add .
    git commit -m "Auto-publish documentation"
    git remote add -t gh-pages origin https://${GH_TOKEN}@github.com/${GH_REF} > /dev/null
    git push -fq origin +gh-pages

fi
