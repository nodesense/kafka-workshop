#!/bin/sh

#define parameters which are passed in.
USER=kafka`< /dev/urandom tr -dc 0-9 | head -c${1:-6}`
#PASSWORD=date +%s | sha256sum | base64 | head -c 32
PASSWORD=`date +%s | sha256sum | base64 | head -c 32`
#define the template.
cat  << EOF
GRANT  ALL ON *.* TO '$USER'@'%' identified by '$PASSWORD';
EOF
