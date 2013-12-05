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

buildPixman()
{
	if [ ! -d pixman-0.32.4 ]; then
		if [ ! -f pixman-0.32.4.tar.gz ]; then
			echo "Download pixman..."
			curl http://cairographics.org/releases/pixman-0.32.4.tar.gz -o pixman-0.32.4.tar.gz
		fi
		tar -xvf pixman-0.32.4.tar.gz
	fi

	pushd pixman-0.32.4

	NDK_ROOT=/Users/chyhfj/.SDK/Android/android-ndk-r9
	CPUFEATURES_INCLUDE=$NDK_ROOT/sources/android/cpufeatures
	FLAGS="--sysroot $ARMSYSROOT/sysroot -I$CPUFEATURES_INCLUDE -DPIXMAN_NO_TLS"

	CC=arm-linux-androideabi-clang CXX=arm-linux-androideabi-clang++ AR=arm-linux-androideabi-ar RANLIB=arm-linux-androideabi-ranlib CPPFLAGS="$FLAGS" CFLAGS="$FLAGS" LDFLAGS="-lcpufeatures" PNG_CFLAGS="-I$ARMSYSROOT/sysroot/usr/include/libpng16" PNG_LIBS="-L$ARMSYSROOT/sysroot/usr/lib -lpng16" ./configure --host=arm-linux-androideabi --prefix=$PREFIX
	make -j4
	make install

	popd
}

# 2.
buildFreetype()
{
	if [ ! -d freetype-2.5.1 ]; then
		if [ ! -f freetype-2.5.1.tar.gz ]; then
			curl http://ftp.twaren.net/Unix/NonGNU//freetype/freetype-2.5.1.tar.gz -o freetype-2.5.1.tar.gz
		fi
		tar -xvf freetype-2.5.1.tar.gz
	fi

	pushd freetype-2.5.1
	
	LIBPNG_CFLAGS="-I$ARMSYSROOT/sysroot/usr/include/libpng16" LIBPNG_LIBS="-L$ARMSYSROOT/sysroot/usr/lib -lpng16" ./configure --host=arm-linux-androideabi --prefix=$PREFIX --without-zlib
	make -j4
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
buildFreetype
# buildFontconfig
buildCairo

