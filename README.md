# docker-base-debian

## Description

A debian based docker image. Preinstalled with curl and [su-exec](#su_exec).

## Configuration

You can configure this image with the following environment variables

| Env           | Description                                      | Example          |
| --------------|:------------------------------------------------:|:----------------:|
| LOCAL_USER_ID | UID of the host user to be used in the container | $(id -u "$USER") |

## Makefile

Tested with GNU Make 3.81. `VERSION` environment variable defaults to `latest`.

### Build

    make build [-e VERSION=x.y]

### Release

    make release [-e VERSION=x.y]

## License

[MIT](LICENSE)

[su_exec]: https://github.com/ncopa/su-exec/
