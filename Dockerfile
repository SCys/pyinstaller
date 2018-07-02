# Official Python base image is needed or some applications will segfault.
FROM alpine:3.7

# Check chinese CDN mirror
RUN apk --update --no-cache add curl
ADD use_chinese_cdn.sh /usr/local/bin
RUN sh /usr/local/bin/use_chinese_cdn.sh 

RUN apk -U --no-cache add python3-dev python3 alpine-sdk 

RUN python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

RUN apk --update --no-cache add \
    libmagic \
    zlib-dev \
    musl-dev \
    libc-dev \
    libffi-dev \
    postgresql-dev \
    gcc \
    g++ \
    git \
    pwgen \
    && pip install --upgrade pip

RUN pip install -U pycrypto setuptools
# RUN pip install git+https://github.com/pyinstaller/pyinstaller.git
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
