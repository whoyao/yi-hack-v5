#!/bin/bash

ARCHIVE=jq-1.6.tar.gz

SCRIPT_DIR=$(cd `dirname $0` && pwd)
cd $SCRIPT_DIR

rm -rf ./_install

if [ ! -f $ARCHIVE ]; then
    wget https://github.com/stedolan/jq/releases/download/jq-1.6/$ARCHIVE
fi
tar zxvf $ARCHIVE

cd jq-1.6 || exit 1

autoreconf -fi
./configure CC=arm-hisiv200-linux-gnueabi-gcc USER_CFLAGS="-march=armv5te -mcpu=arm926ej-s -I/opt/hisi-linux/x86-arm/arm-hisiv200-linux/target/usr/include -L/opt/hisi-linux/x86-arm/arm-hisiv200-linux/target/usr/lib" --host=arm --disable-docs AR=arm-hisiv200-linux-gnueabi-ar RANLIB=arm-hisiv200-linux-gnueabi-ranlib --prefix=$SCRIPT_DIR/_install --disable-maintainer-mode
#    USER_CFLAGS="-march=armv5te -mcpu=arm926ej-s -I/opt/hisi-linux/x86-arm/arm-hisiv200-linux/target/usr/include -L/opt/hisi-linux/x86-arm/arm-hisiv200-linux/target/usr/lib" \
#    AR=arm-hisiv200-linux-gnueabi-ar \
#   RANLIB=arm-hisiv200-linux-gnueabi-ranlib \
   
