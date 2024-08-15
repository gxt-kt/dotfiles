#!/bin/sh

#echo `curl https://github.com/xanmod/linux |grep releases | awk -F/ 'NR==4 {print $(NF)}' | awk -F\" '{print $1}'` > $HOME/.local/log/kernelcheck.log
echo `curl https://github.com/xanmod/linux/tags | grep "xanmod1.tar.gz" | awk -F\/ '{ print$ 7 } ' | awk -F\- '{ print $1 }' | sort | tail -1` > /tmp/kernelcheck.log
