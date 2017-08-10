#!/bin/sh

# entrypoint.sh: Performs the user / group creation and switches
#                to the unprivileged user "user".

# source: https://denibertovic.com/posts/handling-permissions-with-docker-volumes/

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}

echo "==> Starting with UID : $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
export HOME=/home/user

exec /usr/local/bin/su-exec user "$@"
