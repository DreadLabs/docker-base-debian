#!/bin/sh

# entrypoint.sh: Performs the user / group creation and switches
#                to the unprivileged user "user".

# source: https://denibertovic.com/posts/handling-permissions-with-docker-volumes/

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}
SUEXEC_USER=user

echo "==> Starting with UID : $USER_ID"
userdel ${SUEXEC_USER} 2>/dev/null
useradd --shell /bin/false --no-create-home --uid $USER_ID ${SUEXEC_USER}

# Create a named pipe and redirect anything that comes to it
# to stderr connected to Docker.
#
# @see https://github.com/moby/moby/issues/6880#issuecomment-220637337
# @see https://redmine.lighttpd.net/issues/2731#note-15
#
mkfifo --mode 600 /tmp/logpipe
chown "$SUEXEC_USER" /tmp/logpipe
cat <> /tmp/logpipe 1>&2 &

# Provide API for entrypoint users
for f in /etc/entrypoint-suexec.d/*; do
    case "$f" in
        *.sh)   echo "$0: running $f"; . "$f" ;;
        *)      echo "$0: ignoring $f" ;;
    esac
    echo
done

exec /usr/local/bin/su-exec ${SUEXEC_USER} "$@"
