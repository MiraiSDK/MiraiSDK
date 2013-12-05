#!/bin/sh

pushd `pwd`/`dirname $0`
SCRIPT_ROOT=`pwd`
popd

pushd $SCRIPT_ROOT/../../Products/android/android-toolchain-arm
ARMSYSROOT=`pwd`
popd

PREFIX=$ARMSYSROOT/sysroot/usr

#. $ARMSYSROOT/sysroot/usr/share/GNUstep/Makefiles/GNUstep.sh

buildLibPNG()
{
	if [ ! -d libpng-1.6.7 ]; then
		if [ ! -f libpng-1.6.7.tar.gz ]; then
			echo "Download libpng..."
			curl ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng16/libpng-1.6.7.tar.gz -o libpng-1.6.7.tar.gz
		fi
		tar -xvf libpng-1.6.7.tar.gz
	fi

	pushd libpng-1.6.7

	FLAGS="--sysroot $ARMSYSROOT/sysroot"

	CC=arm-linux-androideabi-clang CXX=arm-linux-androideabi-clang++ AR=arm-linux-androideabi-ar CPPFLAGS="$FLAGS" CFLAGS="$FLAGS" ./configure --host=arm-linux-androideabi --prefix=$PREFIX
	make -j4
	make install

	popd
}

buildLibJPEG()
{
	if [ ! -d libjpeg-turbo-1.3.0 ]; then
		if [ ! -f libjpeg-turbo-1.3.0.tar.gz ]; then
			echo "Download libjpeg-turbo..."
			curl http://heanet.dl.sourceforge.net/project/libjpeg-turbo/1.3.0/libjpeg-turbo-1.3.0.tar.gz -o libjpeg-turbo-1.3.0.tar.gz
		fi
		tar -xvf libjpeg-turbo-1.3.0.tar.gz
		
		cp ../tools/config/config.sub libjpeg-turbo-1.3.0/config.sub
		cp ../tools/config/config.guess libjpeg-turbo-1.3.0/config.guess
	fi

	pushd libjpeg-turbo-1.3.0

	CC=arm-linux-androideabi-clang CXX=arm-linux-androideabi-clang++ AR=arm-linux-androideabi-ar RANLIB=arm-linux-androideabi-ranlib  ./configure --host=arm-linux-androideabi --prefix=$PREFIX
	make -j4
	make install

	popd
}

buildLibTIFF()
{
	if [ ! -d tiff-4.0.3 ]; then
		if [ ! -f tiff-4.0.3.tar.gz ]; then
			echo "Download tiff..."
			curl http://download.osgeo.org/libtiff/tiff-4.0.3.tar.gz -o tiff-4.0.3.tar.gz
		fi
		tar -xvf tiff-4.0.3.tar.gz
		cp ../tools/config/config.sub tiff-4.0.3/config/config.sub
		cp ../tools/config/config.guess tiff-4.0.3/config/config.guess
	fi

	pushd tiff-4.0.3

	CC=arm-linux-androideabi-clang CXX=arm-linux-androideabi-clang++ AR=arm-linux-androideabi-ar RANLIB=arm-linux-androideabi-ranlib  ./configure --host=arm-linux-androideabi --prefix=$PREFIX
	make -j4
	make install

	popd
}

buildFontconfig()
{
	if [ ! -d fontconfig ]; then
		git clone git://anongit.freedesktop.org/fontconfig
		
		pushd fontconfig
			patch -p1 -i ../fontconfig_android_lconv.patch
			patch -p1 -i ../fontconfig_autogen.patch
		popd
	fi

	pushd fontconfig

	export PKG_CONFIG_PATH="$ARMSYSROOT/sysroot/usr/lib/pkgconfig"
	CC=arm-linux-androideabi-clang CXX=arm-linux-androideabi-clang++ AR=arm-linux-androideabi-ar RANLIB=arm-linux-androideabi-ranlib CFLAGS="-DANDROID" CPPFLAGS="-DANDROID"  ./configure --host=arm-linux-androideabi --prefix=$PREFIX 
	make -j4
	make install

	popd
}

buildExpat()
{
	if [ ! -d expat-2.1.0 ]; then
		if [ ! -f expat-2.1.0.tar.gz ]; then
			curl http://heanet.dl.sourceforge.net/project/expat/expat/2.1.0/expat-2.1.0.tar.gz -o expat-2.1.0.tar.gz
		fi
		
		tar -xvf expat-2.1.0.tar.gz
	fi

	pushd expat-2.1.0

	CC=arm-linux-androideabi-clang CXX=arm-linux-androideabi-clang++ AR=arm-linux-androideabi-ar RANLIB=arm-linux-androideabi-ranlib  ./configure --host=arm-linux-androideabi --prefix=$PREFIX 
	make -j4
	make install

	popd
}

buildLCMS()
{
	if [ ! -d lcms-1.19 ]; then
		if [ ! -f lcms-1.19.tar.gz ]; then
			curl http://heanet.dl.sourceforge.net/project/lcms/lcms/1.19/lcms-1.19.tar.gz -o lcms-1.19.tar.gz 
		fi
		
		tar -xvf lcms-1.19.tar.gz

		cp ../tools/config/config.sub lcms-1.19/config.sub
		cp ../tools/config/config.guess lcms-1.19/config.guess
		
		pushd lcms-1.19
		patch -p1 -i ../lcms_android_swab.patch
		popd
	fi

	pushd lcms-1.19

	CC=arm-linux-androideabi-clang CXX=arm-linux-androideabi-clang++ AR=arm-linux-androideabi-ar RANLIB=arm-linux-androideabi-ranlib  ./configure --host=arm-linux-androideabi --prefix=$PREFIX 
	make -j4
	make install

	popd
}

#buildLibPNG
#buildLibJPEG
#buildLibTIFF
#buildExpat
#buildFontconfig
#buildLCMS


