#!/bin/sh

IN_CHINA=`curl -s iscys.com | grep -q -i china && echo true || echo false`
if [ "$IN_CHINA" = "true" ]; then 
    sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
    echo "Use china mirror:mirrors.tuna.tsinghua.edu.cn"
fi
