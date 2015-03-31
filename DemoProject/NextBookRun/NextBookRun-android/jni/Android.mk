
LOCAL_PATH := $(call my-dir)
LOCAL_EXPORT_CFLAGS += -g

TN_LIBRARY_PATH := /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/Android18.sdk/usr/lib

# system library
include $(CLEAR_VARS)
LOCAL_MODULE    := dispatch
LOCAL_SRC_FILES := $(TN_LIBRARY_PATH)/libdispatch.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := objc
LOCAL_SRC_FILES := $(TN_LIBRARY_PATH)/libobjc.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := gnustl_shared
LOCAL_SRC_FILES := $(TN_LIBRARY_PATH)/libgnustl_shared.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := gnustep-base
LOCAL_SRC_FILES := $(TN_LIBRARY_PATH)/libgnustep-base.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := TNJavaHelper
LOCAL_SRC_FILES := $(TN_LIBRARY_PATH)/libTNJavaHelper.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := gnustep-corebase
LOCAL_SRC_FILES := $(TN_LIBRARY_PATH)/libgnustep-corebase.so
include $(PREBUILT_SHARED_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE    := CoreGraphics
LOCAL_SRC_FILES := $(TN_LIBRARY_PATH)/libCoreGraphics.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := OpenGLES
LOCAL_SRC_FILES := $(TN_LIBRARY_PATH)/libOpenGLES.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := CoreText
LOCAL_SRC_FILES := $(TN_LIBRARY_PATH)/libCoreText.so
include $(PREBUILT_SHARED_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE    := QuartzCore
LOCAL_SRC_FILES := $(TN_LIBRARY_PATH)/libQuartzCore.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := UIKit
LOCAL_SRC_FILES := $(TN_LIBRARY_PATH)/libUIKit.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := MediaPlayer
LOCAL_SRC_FILES := $(TN_LIBRARY_PATH)/libMediaPlayer.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := NextBookKit
LOCAL_SRC_FILES := libNextBookKit.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := NextBookRun
LOCAL_SRC_FILES := libNextBookRun.so
include $(PREBUILT_SHARED_LIBRARY)

