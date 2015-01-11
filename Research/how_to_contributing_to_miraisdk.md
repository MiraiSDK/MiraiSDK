#How to Contributing to MiraiSDK

To contributing to MiraiSDK, you may needs knows about: [The struct of MiraiSDK](the_struct_of_miraisdk.md)

## Develop workflow

For example, the project MiraiTest

###Task: Build

1. Select Target MiraiTest-Android target
2. Press ⌘+B to build, just like normal Xcode project target

###Task: Install & Run

1. Open a shell, change working folder to MiraiTest-android
2. Run command `ant debug isntall` or `./load.sh` to install application to device
3. manually start application from device

###Task: Debug

1. Open a shell, change working folder to MiraiTest-android
2. Run command `./mirai-gdb` to start app with gdb

###Task: View application log

1. To viewing device log, use command `adb logcat`
2. To viewing only applicaton log, use command `adb logcat -s NSLog`
3. To viewing only iOS style application log, use command `adb logcat -s NSLog | cut -d" " -f5-8-` 

###Task: resolve backtrace

```
I/DEBUG   (  353): *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
I/DEBUG   (  353): UUID: ee71a9c7-0649-4c06-8445-79200b03c32f
I/DEBUG   (  353): Build fingerprint: 'Sony/C6802/C6802:4.4.4/14.4.A.0.108/k___jQ:user/release-keys'
I/DEBUG   (  353): Revision: '0'
I/DEBUG   (  353): pid: 18774, tid: 18794, name: ny4.NextBookRun  >>> org.tiny4.NextBookRun <<<
I/DEBUG   (  353): signal 11 (SIGSEGV), code 1 (SEGV_MAPERR), fault addr 00000020
.
.
.
I/DEBUG   (  353): backtrace:
I/DEBUG   (  353):     #00  pc 0001bc60  /data/app-lib/org.tiny4.NextBookRun-1/libobjc.so (objc_msg_lookup_sender+584)
I/DEBUG   (  353):     #01  pc 00052fb4  /data/app-lib/org.tiny4.NextBookRun-1/libQuartzCore.so
I/DEBUG   (  353):     #02  pc 00052e78  /data/app-lib/org.tiny4.NextBookRun-1/libQuartzCore.so
I/DEBUG   (  353):     #03  pc 000533c8  /data/app-lib/org.tiny4.NextBookRun-1/libQuartzCore.so
I/DEBUG   (  353):     #04  pc 000535b0  /data/app-lib/org.tiny4.NextBookRun-1/libQuartzCore.so


```

If you want to see what is #01,you can use command 

```
arm-linux-androideabi-addr2line -e obj/local/armeabi/libQuartzCore.so 00052fb4

```

## Submit you code

You should fork projects and using pull requests
