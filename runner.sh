#!/bin/sh

nginx 
./check-domains.sh
watch -n20 ./check-domains.sh