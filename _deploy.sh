#!/bin/sh

set -e

[ -z "${GITHUB_PAT}" ] && exit 0
[ "${TRAVIS_BRANCH}" != "master" ] && exit 0

git config --global user.email "gaospecial@gmail.com"
git config --global user.name "Chun-Hui Gao"

git clone -b gh-pages https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git book-output
cd book-output

ls | xargs rm -rf
git ls-files --deleted -z | xargs -0 git rm

cp -r ../_book/* ./
git add --all *
git commit -m "Update the book" || true
git reset $(git commit-tree HEAD^{tree} -m "Update the book")
git push -f -q origin gh-pages