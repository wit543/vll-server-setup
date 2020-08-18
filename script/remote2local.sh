#!/bin/bash

# set -x;

# config key
if [ ! -f "`echo ~`/.ssh/id_rsa" ]; then
    ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
fi


# SSH_USER
# PASSWORD
# HOST

expect -c '
set SSH_USER $env(SSH_USER)
set HOST $env(HOST)
set PASSWORD $env(PASSWORD)
spawn ssh-copy-id $SSH_USER@$HOST
expect {
    "continue" {
        send "yes\n";
        exp_continue
    }
    "assword:" {
        send "$PASSWORD\n";
    }
}
expect eof'

echo "Done $HOST"
