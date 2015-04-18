#!/bin/sh

ant debug install

echo copy assets to device from ${PWD}.
TARGET_PATH="/storage/emulated/legacy/Android/data/org.tiny4.MiraiTests/org.tiny4.MiraiTests.app/"

copyFileToDevice() {
    echo start copy *.$1 files...
    for file in ../Basic/*.$1
        do
        if test -f $file
        then
            echo start copy `basename $file`
            adb push $file ${TARGET_PATH}`basename $file`
        fi
    done
}

copyFileToDevice jpg
copyFileToDevice png
copyFileToDevice mp4
copyFileToDevice m4v

echo Finished Copy!!
