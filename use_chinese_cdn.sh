#!/bin/sh
curl -s iscys.com | grep -q -i china && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories