#!/bin/sh

cp prebuilt/libgnustep-base.so $STANDALONE_TOOLCHAIN_PATH/sysroot/usr/lib/
cp -r prebuilt/GNUstep $STANDALONE_TOOLCHAIN_PATH/sysroot/usr/lib/

cp -r prebuilt/GNUstepBase $STANDALONE_TOOLCHAIN_PATH/sysroot/usr/include/
cp -r prebuilt/Foundation $STANDALONE_TOOLCHAIN_PATH/sysroot/usr/include/

#exit 0

pushd `pwd`/`dirname $0`
SCRIPT_ROOT=`pwd`
popd

pushd $SCRIPT_ROOT/../../Products/android/android-toolchain-arm
ARMSYSROOT=`pwd`
popd

PREFIX=$ARMSYSROOT/sysroot/usr


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
	if [ ! -d gnustep-base-1.24.0 ]; then
		if [ ! -f gnustep-base-1.24.0.tar.gz ]; then
		    curl ftp://ftp.gnustep.org/pub/gnustep/core/gnustep-base-1.24.0.tar.gz > gnustep-base-1.24.0.tar.gz
		fi
		tar -xzf gnustep-base-1.24.0.tar.gz
		
		cp $GNUSTEP_MAKE_CONFIG_PATH/config.sub gnustep-base-1.24.0
		cp $GNUSTEP_MAKE_CONFIG_PATH/config.guess gnustep-base-1.24.0
		
		pushd gnustep-base-1.24.0
		patch -p1 -i ../gsbase_configure_ac.patch
		autoconf
	
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
		
		popd
	fi


	pushd gnustep-base-1.24.0

	
	#export LDFLAGS="-lgnustl_shared"	
	export ac_cv_func_objc_sync_enter=yes
	export ac_cv_func__Block_copy=yes 
	export ac_cv_func_objc_setProperty=yes  
	
	
	CC="$CLANG_ARM" CXX="$CLANGPP_ARM" CPPFLAGS="$SYSROOTFLAGS_ARM" CFLAGS="$SYSROOTFLAGS_ARM" ./configure --prefix=$ARMSYSROOT/sysroot/usr --host="arm-linux-androideabi" --enable-nxconstantstring -disable-xslt --disable-tls --with-xml-prefix=$ARMSYSROOT/sysroot/usr
	checkError $? "configure gnustep-base failed"



	make install

	checkError $? "Make install gnustep-base failed"


	popd
}




buildGNUstepBase

