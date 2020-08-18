#!/bin/bash

# set -x;

# config key
if [ ! -f "`echo ~`/.ssh/id_rsa" ]; then
    ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
fi

HOSTBASE='10.204.100.'
START=111
END=127

for i in $(seq -f "$HOSTBASE%03g" $START $END); do
    # # SSH copy id local to host
    export HOST=$i
    expect -c '
    set SSH_USER $env(USER)
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

    echo "Host to Host Done: $HOST"
done;

