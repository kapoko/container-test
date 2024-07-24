FROM alpine:latest

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22

RUN apk add --no-cache openssh borgbackup \
  && sed -i s/#PasswordAuthentication.*/PasswordAuthentication\ yes/ /etc/ssh/sshd_config \
  && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && sed -i '/#HostKey\ \/etc\/ssh\/ssh_host_ed25519_key/a HostKey\ \~\/.ssh\/id_ecdsa' /etc/ssh/sshd_config \
  && echo "root:root" | chpasswd

