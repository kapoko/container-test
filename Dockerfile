FROM alpine:latest

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22

RUN apk add --no-cache openssh \
  && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config \ 
  && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
  && echo "root:root" | chpasswd

