#!/bin/sh

IN_CHINA=`curl -s iscys.com | grep -q -i china && echo true || echo false`
if [ "$IN_CHINA" == "true" ]; then 
    
    echo "Use china mirror:https://pypi.douban.com/simple/"
fi