clean:
	rm basic
	rm basic-arc
	
basic: Fraction.m main.m
	$(CC) -F../../Products/android/sysroot/System/Library/Frameworks -o basic Fraction.m main.m -lFoundation 
	
basicarc: Fraction.m mainarc.m
	$(CC) -F../../Products/android/sysroot/System/Library/Frameworks -o basic-arc Fraction.m mainarc.m -lFoundation -f-objc-arc
	
push:
	adb push basic /data/local/tmp/basic
	adb push ../../Products/android/android-toolchain-arm/sysroot/usr/lib/libFoundation.so /data/local/tmp/basic
	adb push ../../Products/android/sysroot/System/Library/Frameworks/Foundation.framework/Resources /data/local/tmp/basic/Contents/Resources
	
	#adb push ../../Products/android/sysroot/usr/lib/libobjc.so.4.6.0 /data/local/tmp/basic
	#adb push ../../Products/android/sysroot/usr/lib/libgnustep-base.so.1.24.0 /data/local/tmp/basic

pusharc:
	adb push basic-arc /data/local/tmp/basic
	
	#adb push ../../Products/android/sysroot/usr/lib/libobjc.so.4.6.0 /data/local/tmp/basic
	#adb push ../../Products/android/sysroot/usr/lib/libgnustep-base.so.1.24.0 /data/local/tmp/basic
	
	