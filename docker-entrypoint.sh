#!/bin/bash

# use the private ssh key
if [ -f /id_rsa ]; then
  eval `ssh-agent -s`
  ssh-add /id_rsa
fi

# check if the first argument passed in looks like a flag
if [ "$(printf %c "$1")" = '-' ]; then
  set -- /usr/bin/tini -- ansible-playbook "$@"
# check if the first argument passed in is composer
elif [ "$1" = 'ansible' ]; then
  set -- /usr/bin/tini -- "$@"
fi

exec "$@"