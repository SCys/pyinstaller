#!/bin/sh

# Optmize chinese mirror
IN_CHINA=`curl -s iscys.com | grep -q -i china && echo true || echo false`
if [ "$IN_CHINA" == "true" ]; then 
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
    echo "Use china mirror:mirrors.tuna.tsinghua.edu.cn"
fi