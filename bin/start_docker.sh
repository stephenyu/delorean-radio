#!/bin/bash
ip_address=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`
docker build -t delorean-radio .

docker run --rm -it \
      -e PULSE_SERVER="$ip_address" \
      -v ~/.config/pulse:/home/pulseaudio/.config/pulse \
      delorean-radio
