#!/bin/bash
echo "hello world" > /tmp/temp.txt
apt -y update && apt -y full-upgrade && apt -y autoremove && reboot
