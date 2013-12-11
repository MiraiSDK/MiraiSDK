#!/bin/sh

#use prebuilt 

cp prebuilt/lib/libopal.so $STANDALONE_TOOLCHAIN_PATH/sysroot/usr/lib/
cp -r prebuilt/include/CoreGraphics $STANDALONE_TOOLCHAIN_PATH/sysroot/usr/include/
cp -r prebuilt/include/CoreText $STANDALONE_TOOLCHAIN_PATH/sysroot/usr/include/

exit 0;

pushd `pwd`/`dirname $0`
SCRIPT_ROOT=`pwd`
popd

pushd $SCRIPT_ROOT/../../Products/android/android-toolchain-arm
ARMSYSROOT=`pwd`
popd

PREFIX=$ARMSYSROOT/sysroot/usr

. $ARMSYSROOT/sysroot/usr/share/GNUstep/Makefiles/GNUstep.sh

# getting sources
if [ ! -d gnustep-opal ]; then
	git clone https://github.com/gnustep/gnustep-opal.git
	
	pushd gnustep-opal/Source/OpalGraphics
	mv opal-x11.m opal-x11.m.disabled
	popd
fi

# compile
pushd gnustep-opal

export PKG_CONFIG_PATH="$ARMSYSROOT/sysroot/usr/lib/pkgconfig"
#CC=arm-linux-androideabi-clang CXX=arm-linux-androideabi-clang++ AR=arm-linux-androideabi-ar CPPFLAGS="--sysroot $ARMSYSROOT/sysroot -F$ARMSYSROOT/sysroot/System/Library/Frameworks" CFLAGS="--sysroot $ARMSYSROOT/sysroot -F$ARMSYSROOT/sysroot/System/Library/Frameworks" ./configure --host=arm-linux-androideabi --prefix=$PREFIX

make
make install

popd