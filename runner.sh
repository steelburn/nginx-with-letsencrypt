#!/bin/sh
export TERM=xterm
nginx 
./check-domains.sh
watch -n20 ./check-domains.sh