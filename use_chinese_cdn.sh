#!/bin/bash

IN_CHINA=`curl -s http://whatismyip.akamai.com/advanced | grep -q -i -i CN && echo true || echo false`

if [[ "$IN_CHINA" == "true" ]]; then 
    sed -i "s@ftp.debian.org@mirrors.aliyun.com@g"      /etc/apt/sources.list 
    sed -i "s@deb.debian.org@mirrors.aliyun.com@g"      /etc/apt/sources.list
    sed -i "s@security.debian.org@mirrors.aliyun.com@g" /etc/apt/sources.list
    echo "setup deb mirror:mirrors.aliyun.com"

    pip config set global.index-url https://pypi.douban.com/simple/
    echo "setup pip index:https://pypi.douban.com/simple/"
fi