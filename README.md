# docker-base-debian

## Description

A debian based docker image. Preinstalled with curl and [su-exec](#su_exec).

## Configuration

You can configure this image with the following environment variables

| Env           | Description                                      | Example          |
| --------------|:------------------------------------------------:|:----------------:|
| LOCAL_USER_ID | UID of the host user to be used in the container | $(id -u "$USER") |

## Makefile

Tested with GNU Make 3.81.

### List available versions to build

    > make versions-avail
    < 8-jessie/
    < 9-stretch/

### Build

    make build -e VERSION=n-...

### Release

    make release -e VERSION=n-...

## License

[MIT](LICENSE)

[su_exec]: https://github.com/ncopa/su-exec/
