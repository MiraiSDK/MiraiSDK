#How To Build Android Target Manually


##Xcode part
1. add static library target
2. copy and add Android.xcconfig to project and set it as configuration
3. change Mach-O Type to dynamic library
4. remove Other Linker Flags override
5. Link UIKit.framework
5. remove Installation Build Products Location override
6. change Skit Install to No
7. add lanucher class 
8. add ``[[UIScreen mainScreen] setScreenMode:UIScreenSizeModePad scale:0];``
9. create UIWindow and rootViewController
10. add ndk-build script


##Android part

### 1. create android project

run command in android folder :

```
android create project --target 1 --name Demo --path ./ --activity MainActivity --package org.tiny4.Demo
```

### 2. create jni/Android.mk

see [Android.mk](Android_files/Android.mk)


###3. copy CocoaActivity folder


###4. modify java file, 
	
1. add ``import org.tiny4.CocoaActivity.CocoaActivity; ``
2. change super class to ``CocoaActivity``
3. load library

### 5. modify AndroidManifest.xml

add to application

```
        android:hasCode="true"
        android:theme="@android:style/Theme.NoTitleBar.Fullscreen"

```

add to activity

```
	<activity android:screenOrientation="sensor" android:configChanges="orientation|keyboardHidden|screenSize">

	<meta-data android:name="android.app.lib_name" android:value="UIKit"/>

```

add permission

```
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```
