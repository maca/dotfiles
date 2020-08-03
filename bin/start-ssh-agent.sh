#!/usr/bin/env sh

export SSH_AUTH_SOCK=/run/user/$UID/ssh-agent.socket
ssh-add -l >/dev/null 2>&1

if [ $? -ne 0 ]; then
   rm -rf $SSH_AUTH_SOCK
   eval $(ssh-agent -t 1h -a $SSH_AUTH_SOCK 2>/dev/null)
fi
