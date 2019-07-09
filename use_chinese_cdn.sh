#!/bin/sh

curl -s https://api.ip.sb/geoip | grep -q -i china \
    && \
    (sed -i 's/deb.debian.org/mirrors.huaweicloud.com/g' /etc/apt/sources.list && \
        echo "Use china mirror:mirrors.huaweicloud.com") || \
    echo "Use system default repo"
