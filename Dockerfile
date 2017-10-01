FROM debian:stretch

MAINTAINER Thomas Juhnke <dev@van-tomas.de>

ENV SUEXEC_VERSION v0.2

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y apt-transport-https curl gcc make \
    && dir="$(mktemp -d)" \
    && cd $dir \
    && curl --location --remote-name https://github.com/ncopa/su-exec/archive/${SUEXEC_VERSION}.tar.gz \
    && tar --strip-components=1 -xzf ${SUEXEC_VERSION}.tar.gz \
    && make \
    && mv su-exec /usr/local/bin \
    && rm -rf $dir \
    && apt-get remove -y --purge gcc make \
    && apt-get autoremove -y --purge \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD rootfs/ /

