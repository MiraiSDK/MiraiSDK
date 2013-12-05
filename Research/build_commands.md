###Build OBJC
```
mkdir Build
cd Build
cmake -DCMAKE_TOOLCHAIN_FILE=/Users/chyhfj/.SDK/Android/toolchain-arm/toolchain.cmake ..
make objc
```

### Build ffi
```
mkdir Build
RANLIB=/Users/chyhfj/.SDK/Android/toolchain-arm/bin/arm-linux-androideabi-ranlib CC=/Users/chyhfj/.SDK/Android/toolchain-arm/bin/arm-linux-androideabi-clang ../configure --host=arm-linux-gnu
```

### gnustep-make
```
CC=/Users/chyhfj/Development/SyoujoSDK/Working/toolchain-arm/bin/arm-linux-androideabi-clang CXX=/Users/chyhfj/Development/SyoujoSDK/Working/toolchain-arm/bin/arm-linux-androideabi-clang++  ../configure --prefix="/Users/chyhfj/Development/SyoujoSDK/Working/toolchain-arm/" --host=arm-linux-androideabi
```

###gnustep-base
```
CC=/Users/chyhfj/Development/SyoujoSDK/Working/toolchain-arm/bin/arm-linux-androideabi-clang CXX=/Users/chyhfj/Development/SyoujoSDK/Working/toolchain-arm/bin/arm-linux-androideabi-clang++ CFLAGS="-lobjc --verbose" CXXFLAGS="-lstdc++ -lobjc" ./configure --prefix="/Users/chyhfj/Development/SyoujoSDK/Working/toolchain-arm/" --host=arm-linux-androideabi --enable-nxconstantstring --with-ffi-include="/Users/chyhfj/Development/SyoujoSDK/Working/toolchain-arm/sysroot/usr/include/ffi" --with-ffi-library="/Users/chyhfj/Development/SyoujoSDK/Working/toolchain-arm/sysroot/usr/lib" --with-libiconv-library="/Users/chyhfj/Development/SyoujoSDK/Working/toolchain-arm/sysroot/usr/lib" --with-libiconv-include="/Users/chyhfj/Development/SyoujoSDK/Working/toolchain-arm/sysroot/usr/include"
```