#!/bin/sh

curl -s https://api.ip.sb/geoip | grep -q -i china && \
    sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list && \
    echo "Use china mirror:mirrors.tuna.tsinghua.edu.cn"
