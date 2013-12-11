#!/bin/sh

pushd `pwd`/`dirname $0`
SCRIPT_ROOT=`pwd`
popd

pushd $SCRIPT_ROOT/../../Products/android/android-toolchain-arm
ARMSYSROOT=`pwd`
popd

PREFIX=$ARMSYSROOT/sysroot/usr

. $ARMSYSROOT/sysroot/usr/share/GNUstep/Makefiles/GNUstep.sh

# 1. Pixman
checkError()
{
    if [ "${1}" -ne "0" ]; then
        echo "*** Error: ${2}"
        exit ${1}
    fi
}

buildCPUFeature()
{
	if [ ! -f $ARMSYSROOT/sysroot/usr/lib/cpufeatures.a ]; then
		pushd $ANDROID_NDK_PATH/sources/android/cpufeatures
		$CLANG_ARM -c -o cpu-features.o cpu-features.c
		$AR_ARM rcs cpufeatures.a cpu-features.o
		mv cpufeatures.a $ARMSYSROOT/sysroot/usr/lib/
		rm cpu-features.o
		popd
	fi

}

buildPixman()
{
	buildCPUFeature
	
	if [ ! -d pixman-0.32.4 ]; then
		if [ ! -f pixman-0.32.4.tar.gz ]; then
			echo "Download pixman..."
			curl http://cairographics.org/releases/pixman-0.32.4.tar.gz -o pixman-0.32.4.tar.gz
		fi
		tar -xvf pixman-0.32.4.tar.gz
	fi

	pushd pixman-0.32.4

	CPUFEATURES_INCLUDE=$ANDROID_NDK_PATH/sources/android/cpufeatures
	FLAGS="--sysroot $ARMSYSROOT/sysroot -I$CPUFEATURES_INCLUDE -DPIXMAN_NO_TLS"

	CC="$CLANG_ARM" CXX="$CLANGPP_ARM" AR="$AR_ARM" RANLIB="$RANLIB_ARM" CPPFLAGS="$FLAGS" CFLAGS="$FLAGS" LDFLAGS="-l$ARMSYSROOT/sysroot/usr/lib/cpufeatures.a" PNG_CFLAGS="-I$ARMSYSROOT/sysroot/usr/include" PNG_LIBS="-L$ARMSYSROOT/sysroot/usr/lib -lpng" ./configure --host=arm-linux-androideabi --prefix=$PREFIX
	make -j4
	checkError $? "Make pixman failed"
	
	make install

	popd
}


#3. 
buildCairo()
{
	if [ ! -d cairo-1.12.14 ]; then
		if [ ! -f cairo-1.12.14.tar.xz ]; then
			curl http://cairographics.org/releases/cairo-1.12.14.tar.xz -o cairo-1.12.14.tar.xz
		fi
		tar -xJf cairo-1.12.14.tar.xz
		
		pushd cairo-1.12.14
		patch -p1 -i ../cairo_android_lconv.patch
		popd
	fi

	# compile
	pushd cairo-1.12.14
	export PKG_CONFIG_LIBDIR="${ARMSYSROOT}/sysroot/usr/lib/pkgconfig:${ARMSYSROOT}/sysroot/usr/share/pkgconfig"
	ARMCFLAGS="-DANDROID --sysroot $ARMSYSROOT/sysroot"
	
	CC=arm-linux-androideabi-clang CXX=arm-linux-androideabi-clang++ AR=arm-linux-androideabi-ar CPPFLAGS="$ARMCFLAGS" CFLAGS="$ARMCFLAGS" ./configure --host=arm-linux-androideabi --prefix=$PREFIX --enable-xlib=no --enable-glesv2 --enable-shared=no
	make -j4
	make install

	popd
}


buildPixman
checkError $? "Make pixman failed"

#buildFreetype
# buildFontconfig
buildCairo
checkError $? "Make cairo failed"


