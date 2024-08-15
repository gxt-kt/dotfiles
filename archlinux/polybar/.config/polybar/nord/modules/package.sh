#!/bin/bash

doas eix-sync -a
echo `doas emerge -pvuDN @world` > /tmp/packagecheck.log
