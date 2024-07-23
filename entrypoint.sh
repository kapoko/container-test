#!/bin/ash

# generate host keys if not present
ssh-keygen -A

if [ ${SSH_PORT:-22} != 22 ]
then
  sed -i s/#Port.*/Port\ $SSH_PORT/ /etc/ssh/sshd_config
fi

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
