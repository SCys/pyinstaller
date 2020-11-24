# Official Python base image is needed or some applications will segfault.
FROM python:3.9-buster

# Check chinese CDN mirror
ADD use_chinese_cdn.sh /usr/local/bin
# RUN bash /usr/local/bin/use_chinese_cdn.sh

RUN apt-get update -qq -y \
    && apt-get install --no-install-recommends -qq -f -y \
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
        libsnappy-dev \
        libcurl4-openssl-dev \
        upx-ucl \
    && apt-get clean

# RUN pip install --upgrade pip setuptools && pip install pycryptodome tinyaes
# RUN git clone --depth 1 --single-branch https://github.com/pyinstaller/pyinstaller.git /tmp/pyinstaller && \
#     cd /tmp/pyinstaller/bootloader && \
#     python ./waf configure --no-lsb all && \
#     pip install .. && \
#     rm -Rf /tmp/pyinstaller

RUN pip install --upgrade pip setuptools && pip install pyinstaller[encryption]

VOLUME /src
WORKDIR /src

ADD ./bin /pyinstaller
RUN chmod a+x /pyinstaller/*

ENTRYPOINT ["/pyinstaller/pyinstaller.sh"]
