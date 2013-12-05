#!/bin/sh

pushd `pwd`/`dirname $0`
SCRIPT_ROOT=`pwd`
popd

pushd $SCRIPT_ROOT/../../Products/android/android-toolchain-arm
ARMSYSROOT=`pwd`
popd

PREFIX=$ARMSYSROOT/sysroot/usr

CLANG_ARM=arm-linux-androideabi-clang
CLANGPP_ARM=arm-linux-androideabi-clang++

GCC_ARM=$ARMSYSROOT/bin/arm-linux-androideabi-gcc
LD_ARM=$ARMSYSROOT/bin/arm-linux-androideabi-ld

GXX_ARM=$ARMSYSROOT/bin/arm-linux-androideabi-g++

AR_ARM=$ARMSYSROOT/bin/arm-linux-androideabi-ar
RANLIB_ARM=$ARMSYSROOT/bin/arm-linux-androideabi-ranlib
OBJDUMP_ARM=$ARMSYSROOT/bin/arm-linux-androideabi-objdump

SYSROOTFLAGS_ARM="--sysroot $ARMSYSROOT/sysroot"

checkError()
{
    if [ "${1}" -ne "0" ]; then
        echo "*** Error: ${2}"
        exit ${1}
    fi
}

buildGNUstepBase()
{
	if [ ! -f gnustep-base-1.24.0.tar.gz ]; then
	    curl ftp://ftp.gnustep.org/pub/gnustep/core/gnustep-base-1.24.0.tar.gz > gnustep-base-1.24.0.tar.gz
	fi
	tar -xzf gnustep-base-1.24.0.tar.gz

	cp tools/config/config.sub gnustep-base-1.24.0
	cp tools/config/config.guess gnustep-base-1.24.0

	pushd gnustep-base-1.24.0

	patch -p1 -i ../gsbase_configure_ac.patch
	autoconf
	
	export LDFLAGS="-lgnustl_shared"

	CC="$CLANG_ARM" CXX="$CLANGPP_ARM" CPPFLAGS="$SYSROOTFLAGS_ARM" CFLAGS="$SYSROOTFLAGS_ARM" ./configure --prefix=$ARMSYSROOT/sysroot/usr --host="arm-linux-androideabi" --enable-nxconstantstring -disable-xslt --disable-tls --with-xml-prefix=$ARMSYSROOT/sysroot/usr
	checkError $? "configure gnustep-base failed"

	# patches to build gnustep-base-1.24.0 with libxml2-2.90.0 patch from [bug #37609] (fixed in svn)
	patch -p0 -i ../patch-af

	# android define an empty struct lconv
	patch -p1 -i ../gsbase_GSLocale.patch

	# android dosen't define pw_gecos
	patch -p1 -i ../gsbase_NSPathUtilities.patch 

	patch -p1 -i ../gsbase_FNDELAY.patch

	# don't build SSL Tools and Tests subprojects
	patch -p1 -i ../gsbase_GNUmakefile.patch

	# android don't have nan
	patch -p1 -i ../gsbase_NSDate.patch

	make install

	checkError $? "Make install gnustep-base failed"


	popd
}

if [ ! -d tools/config ]; then
    git clone http://git.savannah.gnu.org/r/config.git/ tools/config
fi

. $ARMSYSROOT/sysroot/usr/share/GNUstep/Makefiles/GNUstep.sh

buildGNUstepBase

