#!/bin/sh
# scripts references from http://thebugfreeblog.blogspot.jp/2013/05/cross-building-icu-for-applications-on.html

pushd `pwd`/`dirname $0`
SCRIPT_ROOT=`pwd`
popd

pushd $SCRIPT_ROOT/../../../Products/android/android-toolchain-arm
NDK_STANDARD_ROOT=`pwd`
popd
ICU_PREFIX=$NDK_STANDARD_ROOT/sysroot/usr

pushd $SCRIPT_ROOT

checkError()
{
    if [ "${1}" -ne "0" ]; then
        echo "*** Error: ${2}"
        exit ${1}
    fi
}

# 1.download icu
if [ ! -d icu ]; then
	echo "Downloding icu from SVN..."
	svn export http://source.icu-project.org/repos/icu/icu/tags/release-52-1/ icu
fi

#2. build build target, assume is OSX
buildOSXVersion()
{
	echo "Build osx target..."
	mkdir $SCRIPT_ROOT/build_icu_osx

	pushd $SCRIPT_ROOT/build_icu_osx

	export CPPFLAGS="-O3 -fno-short-wchar -DU_USING_ICU_NAMESPACE=1 -fno-short-enums \
	-DU_HAVE_NL_LANGINFO_CODESET=0 -D__STDC_INT64__ -DU_TIMEZONE=1 \
	-DUCONFIG_NO_LEGACY_CONVERSION=1 -DUCONFIG_NO_TRANSLITERATION=0"

	../icu/source/runConfigureICU MacOSX --prefix=$PWD/icu_build --enable-extras=no --enable-strict=no -enable-static -enable-shared --enable-tests=no --enable-samples=no --enable-dyload=no
	make -j4
	make install
    checkError $? "Make install osx version failed"
	
	popd	
}

#3. build host target
buildAndroidVersion()
{
	echo "build android target..."
	mkdir $SCRIPT_ROOT/build_icu_android
	pushd $SCRIPT_ROOT/build_icu_android

	export HOST_ICU=$SCRIPT_ROOT/build_icu_android
	export ICU_CROSS_BUILD=$SCRIPT_ROOT/build_icu_osx
	
	#
	# -DU_TIMEZONE=1
	# -DUCONFIG_NO_REGULAR_EXPRESSIONS=0
	# -DUCONFIG_NO_FORMATTING=0
	#
	# Knowing gnustep-corebase required features
	# required BREAK_ITERATION (-DUCONFIG_NO_BREAK_ITERATION = 0)
	# required COLLATION (-DUCONFIG_NO_COLLATION=0)
	#
	export CPPFLAGS="-I$NDK_STANDARD_ROOT/sysroot/usr/include/ \
	-O3 -fno-short-wchar -DU_USING_ICU_NAMESPACE=1 -fno-short-enums \
	-DU_HAVE_NL_LANGINFO_CODESET=0 -D__STDC_INT64__ -DU_TIMEZONE=1 \
	-DUCONFIG_NO_LEGACY_CONVERSION=1 -DUCONFIG_NO_TRANSLITERATION=0"
	export LDFLAGS="-lc -lgnustl_shared -Wl,-rpath-link=$NDK_STANDARD_ROOT/sysroot/usr/lib/"

	../icu/source/configure --with-cross-build=$ICU_CROSS_BUILD \
	--enable-extras=no --enable-strict=no -enable-static -enable-shared \
	--enable-tests=no --enable-samples=no --enable-dyload=no \
	--host=arm-linux-androideabi --prefix=$ICU_PREFIX
	make -j4
	make install 

	popd
}

buildOSXVersion
checkError $? "Make install osx version failed"

buildAndroidVersion
checkError $? "Make install android version failed"


#clean 
echo "Clean..."
rm -rf build_icu_osx
rm -rf build_icu_android
popd
