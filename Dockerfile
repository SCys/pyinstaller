# Official Python base image is needed or some applications will segfault.
FROM debian:sid-slim

# Check chinese CDN mirror
RUN apt update -qy && apt install -qfy curl
ADD use_chinese_cdn.sh /usr/local/bin
RUN sh /usr/local/bin/use_chinese_cdn.sh 

RUN apt update -qy \
    && apt install --no-install-recommends -qfy \
        python3-dev python3 python3-pip \
        libmagic-dev \
        zlib1g-dev \
        musl-dev \
        libssl-dev \
        libc-dev-bin \
        libffi-dev \
        libpq-dev \
        build-essential \
        gcc \
        g++ \
        pwgen \
        git \
        libcurl4-openssl-dev \
    && apt clean

RUN pip3 install --upgrade pip setuptools && \
    ln -s pip3 /usr/bin/pip && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    rm -r /root/.cache

RUN pip install pycrypto

RUN git clone --depth 1 --single-branch https://github.com/pyinstaller/pyinstaller.git /tmp/pyinstaller \
    && cd /tmp/pyinstaller/bootloader \
    && python3 ./waf configure --no-lsb all \
    && pip3 install .. \
    && rm -Rf /tmp/pyinstaller

VOLUME /src
WORKDIR /src

ADD ./bin /pyinstaller
RUN chmod a+x /pyinstaller/*

ENTRYPOINT ["/pyinstaller/pyinstaller.sh"]
