#!/bin/sh
#sed -i 's#Port 22#Port 30022#' /etc/ssh/sshd_config
cat <<EOF >> /etc/ssh/sshd_config
Port 30022
PubkeyAcceptedAlgorithms +ssh-rsa
EOF
if [ "$1" = "server" ];then
  /entry.sh /usr/sbin/sshd -D -e -f /etc/ssh/sshd_config
elif [ "$1" = "debug" ];then
  sh
else
  export SSH_REMOTE_HOST=$1
  export SSH_REMOTE_PORT=${PORT:-30022}
  export SSH_REMOTE_USER=${USER:-root}
  export SSH_MODE=-R
  export SSH_BIND_IP=0.0.0.0
  export SSH_TUNNEL_PORT=80
  export SSH_TARGET_HOST=${LOCAL_HOST}
  export SSH_TARGET_PORT=${LOCAL_PORT}
  export SSH_KEY_FILE=${KEY:-/root/.ssh/id_rsa}
  test -z "${SSH_TARGET_HOST}" && echo "not set \$LOCAL_HOST" && exit 1
  test -z "${SSH_TARGET_PORT}" && echo "not set \$LOCAL_PORT" && exit 1
  test ! -s "${SSH_KEY_FILE}"  && echo "not set \$KEY" && exit 1
  /app/client-entrypoint.sh
fi
