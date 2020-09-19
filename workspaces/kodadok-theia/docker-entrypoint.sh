#!/bin/bash
set -e

# Change uid and gid of node user so it matches ownership of current dir
if [ "$MAP_NODE_UID" != "no" ]; then
    if [ ! -d "$MAP_NODE_UID" ]; then
        MAP_NODE_UID=$PWD
    fi

    uid=$(stat -c '%u' "$MAP_NODE_UID")
    gid=$(stat -c '%g' "$MAP_NODE_UID")

    export USER=${NON_ROOT_USER}

    usermod -u $uid $USER 2> /dev/null && {
      groupmod -g $gid $USER 2> /dev/null || usermod -a -G $gid $USER
    }
fi

mkdir -p /home/${USER}/workspace
chown -R ${USER}:${USER} /home/${USER}/workspace
cd /home/${USER}/workspace
exec gosu ${USER} bash -c '/usr/local/theia/node/bin/node /usr/local/theia/src-gen/backend/main.js /home/${USER}/workspace --app-project-path /usr/local/theia --hostname=0.0.0.0 --port=28801'