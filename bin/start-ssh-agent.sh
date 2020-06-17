#!/usr/bin/env sh

export SSH_AUTH_SOCK=/tmp/ssh-agent.socket
ssh-add -l >/dev/null 2>&1
if [ $? = 2 ]; then
   rm -rf $SSH_AUTH_SOCK
   eval $(ssh-agent -a $SSH_AUTH_SOCK)
fi
