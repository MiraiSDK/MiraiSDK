#!/bin/sh

cp /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/Android18.sdk/usr/lib/libQuartzCore.so ./jni/
ndk-build
ant debug install