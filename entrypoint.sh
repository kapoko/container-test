#!/bin/ash

# Generate host keys if not present
ssh-keygen -t ecdsa -f ~/.ssh/id_ecdsa -q -N ""

# Change port if set
if [ ${SSH_PORT:-22} != 22 ]; then
    sed -i s/#Port.*/Port\ $SSH_PORT/ /etc/ssh/sshd_config
fi

# Change password if set
if [ ${ROOT_PASSWORD:-"root"} != "root" ]; then
    echo "root:$ROOT_PASSWORD" | chpasswd
fi

# Do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
