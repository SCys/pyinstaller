# Official Python base image is needed or some applications will segfault.
FROM debian:sid-slim

# Check chinese CDN mirror
RUN apt update -qy && apt install -qfy curl
ADD use_chinese_cdn.sh /usr/local/bin
RUN sh /usr/local/bin/use_chinese_cdn.sh 

RUN apt update -qy \
    && apt install --no-install-recommends -qfy \
        python3.7 \
        python3.7-dev \
        python3.7-distutils \
        libmagic-dev \
        zlib1g-dev \
        musl-dev \
        libssl-dev \
        libc-dev-bin \
        libffi-dev \
        libpq-dev \
        libsnappy-dev \
        build-essential \
        gcc \
        g++ \
        pwgen \
        git \
        libcurl4-openssl-dev \
    && apt clean

RUN ln -sf /usr/bin/python3.7 /usr/bin/python && \
    curl https://bootstrap.pypa.io/get-pip.py | python && \
    pip install --upgrade pip setuptools

RUN pip install PyCrypto

RUN git clone --depth 1 --single-branch https://github.com/pyinstaller/pyinstaller.git /tmp/pyinstaller && \
    cd /tmp/pyinstaller/bootloader && \
    python ./waf configure --no-lsb all && \
    pip install .. && \
    rm -Rf /tmp/pyinstaller

VOLUME /src
WORKDIR /src

ADD ./bin /pyinstaller
RUN chmod a+x /pyinstaller/*

ENTRYPOINT ["/pyinstaller/pyinstaller.sh"]
