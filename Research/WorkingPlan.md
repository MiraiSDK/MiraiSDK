* Windows
	* cocotron add UIKit (2 w)
	* MikuSDK to Windows (1 w)
* Android
	* stella SDK to MikuSDK (2-3w)
* common
	* libdispatch (ok)
	* libobjc (ok)
	* CoreText (workaround)
	* Core Foundation (GNUStep)
	* Foundation (GNUStep)
	* Core Graphics (1 w)
	* Core Animation (Quartz Core) (4 d)
	* UIKit (1 w)

	
-----

Steps

 1. stella SDK to MikuSDK (2-3w) 
 	* use android toolchain to compile library (Done)
 	* use android toolchain to compile xcode project .so
 	* a working runtimew
 		* libobjc (done)
 		* libdispatch (done)
 		* block (done)
		* test (2 d)
		* arc
		* test arc
 	
 2. workaround (3 w)
 3. port to Windows (1 w)
 
 all: 6-7 w
 
 final Date: 1月6日
