#!/bin/bash

# set -x;

# config key
if [ ! -f "`echo ~`/.ssh/id_rsa" ]; then
    ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
fi

# Read username as password
echo "What is your REMOTE username?"
read SSH_USER
export SSH_USER
echo "What is your REMOTE password?"
read -s PASSWORD 
export PASSWORD
HOSTBASE='10.204.100.'
START=126
END=127

echo "What is your LOCAL IP?"
read LOCAL_IP 
export LOCAL_IP
echo "What is your LOCAL password?"
read -s LOCAL_PASSWORD 
export LOCAL_PASSWORD


for i in $(seq -f "$HOSTBASE%03g" $START $END); do
    # # SSH copy id local to host
    export HOST=$i
    # expect -c '
    # set SSH_USER $env(SSH_USER)
    # set HOST $env(HOST)
    # set PASSWORD $env(PASSWORD)
    # spawn ssh-copy-id $SSH_USER@$HOST
    # expect {
    #     "continue" {
    #         send "yes\n";
    #         exp_continue
    #     }
    #     "assword:" {
    #         send "$PASSWORD\n";
    #     }
    # }
    # expect eof'

    # echo "Local to Host Done: $HOST"

    # # SSH copy id host to local
    # scp  remote2local.sh $SSH_USER@$HOST:~/
    # # echo ssh $SSH_USER@$HOST "SSH_USER=$USER HOST=$LOCAL_IP PASSWORD=$LOCAL_PASSWORD bash ~/remote2local.sh"
    # ssh $SSH_USER@$HOST "SSH_USER=$USER HOST=$LOCAL_IP PASSWORD=$LOCAL_PASSWORD bash ~/remote2local.sh"
    # echo "Host to Local Done: $HOST"

    # SSH copy id host to host
    scp  remote2remote.sh $SSH_USER@$HOST:~/
    # echo ssh $SSH_USER@$HOST "SSH_USER=$USER HOST=$LOCAL_IP PASSWORD=$LOCAL_PASSWORD bash ~/remote2local.sh"
    ssh $SSH_USER@$HOST "PASSWORD=$LOCAL_PASSWORD bash ~/remote2remote.sh"
    echo "Host to host Done: $HOST"
done;

