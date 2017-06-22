#!/usr/bin/env bash
set -e

if [ "$HOSTNAME" = "salt" ]; then
    systemctl enable salt-master
else
    systemctl disable salt-master
fi

systemctl enable salt-minion

exec /usr/sbin/init
