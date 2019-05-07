#!/bin/bash
# Simple wrapper around pyinstaller

set -e

# Generate a random key for encryption
random_key=$(pwgen -s 16 1)
pyinstaller_args="${@/--random-key/--key $random_key}"

# Use the hacked ldd to fix libc.musl-x86_64.so.1 location
PATH="/pyinstaller:$PATH"

# Optmize chinese mirror
pip_args=""
IN_CHINA=`curl -s https://api.ip.sb/geoip/ | grep -q -i china && echo true || echo false`
if [ "$IN_CHINA" == "true" ]; then 
    pip_args="-i https://pypi.douban.com/simple/"
    echo "Use china mirror:https://pypi.douban.com/simple/"
fi

if [ -f requirements.txt ]; then
    pip install $pip_args -r requirements.txt
elif [ -f setup.py ]; then
    pip install $pip_args .
fi

# Exclude pycrypto and PyInstaller from built packages
exec pyinstaller \
    --exclude-module pycrypto \
    --exclude-module PyInstaller \
    ${pyinstaller_args}
