# Official Python base image is needed or some applications will segfault.
FROM python:3

RUN set -x \
    && apt-get update -qy \
    && apt-get install --no-install-recommends -qfy \
        zlib1g-dev \
        musl-dev \
        libc-dev-bin \
        gcc \
        pwgen \
        git \
    && apt-get clean

RUN pip install pycrypto

RUN git clone --depth 1 --single-branch https://github.com/pyinstaller/pyinstaller.git /tmp/pyinstaller \
    && cd /tmp/pyinstaller/bootloader \
    && python ./waf configure --no-lsb all \
    && pip install .. \
    && rm -Rf /tmp/pyinstaller

VOLUME /src
WORKDIR /src

ADD ./bin /pyinstaller
RUN chmod a+x /pyinstaller/*

ENTRYPOINT ["/pyinstaller/pyinstaller.sh"]
