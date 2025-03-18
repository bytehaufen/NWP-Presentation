#! /usr/bin/env bash

ARGS=$@

if [ $# -eq 0 ]; then
  echo 'No commit message was given. Exiting...'
  exit 1
fi

git add . &&
  git commit -m "$@" &&
  git push
