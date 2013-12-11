#!/bin/sh

pushd `pwd`/`dirname $0`
SCRIPT_ROOT=`pwd`
popd

pushd $SCRIPT_ROOT/../../Products/android/android-toolchain-arm
ARMSYSROOT=`pwd`
popd

PREFIX=$ARMSYSROOT/sysroot/usr

#. $ARMSYSROOT/sysroot/usr/share/GNUstep/Makefiles/GNUstep.sh

# need icu
if [ ! -f $ARMSYSROOT/sysroot/usr/lib/libicui18n.a ]; then
	pushd icu
	./build_icu
	popd
fi

# getting sources
if [ ! -d gnustep-corebase ]; then
	git clone https://github.com/gnustep/gnustep-corebase.git
	
	pushd gnustep-corebase
	patch -p1 -i  ../corebase_linkgnustl.patch
	popd
fi

# compile
pushd gnustep-corebase

# needs add 'ac_cv_func_*' to avoid autoconf incorrect use rpl_malloc/rpl_realloc
ac_cv_func_malloc_0_nonnull=yes ac_cv_func_realloc_0_nonnull=yes CC="$CLANG_ARM" CXX="$CLANGPP_ARM" AR="$AR_ARM" CPPFLAGS="--sysroot $ARMSYSROOT/sysroot -F$ARMSYSROOT/sysroot/System/Library/Frameworks" CFLAGS="--sysroot $ARMSYSROOT/sysroot -F$ARMSYSROOT/sysroot/System/Library/Frameworks" LDFLAGS="-l$ARMSYSROOT/sysroot/usr/lib/libgcc.a" ./configure --host=arm-linux-androideabi --prefix=$PREFIX

make -j4
make install
make clean

popd