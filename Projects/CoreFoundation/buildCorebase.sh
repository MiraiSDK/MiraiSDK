#!/bin/sh

pushd `pwd`/`dirname $0`
SCRIPT_ROOT=`pwd`
popd

pushd $SCRIPT_ROOT/../../Products/android/android-toolchain-arm
ARMSYSROOT=`pwd`
popd

PREFIX=$ARMSYSROOT/sysroot/usr

. $ARMSYSROOT/sysroot/usr/share/GNUstep/Makefiles/GNUstep.sh

# getting sources
if [ ! -d gnustep-corebase ]; then
	git clone https://github.com/gnustep/gnustep-corebase.git
fi

# compile
pushd gnustep-corebase

CC=arm-linux-androideabi-clang CXX=arm-linux-androideabi-clang++ AR=arm-linux-androideabi-ar CPPFLAGS="--sysroot $ARMSYSROOT/sysroot -F$ARMSYSROOT/sysroot/System/Library/Frameworks" CFLAGS="--sysroot $ARMSYSROOT/sysroot -F$ARMSYSROOT/sysroot/System/Library/Frameworks" ./configure --host=arm-linux-androideabi --prefix=$PREFIX

make install

popd