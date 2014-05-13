
LOCAL_PATH := $(call my-dir)
LOCAL_EXPORT_CFLAGS += -g


include $(CLEAR_VARS)
LOCAL_MODULE    := dispatch
LOCAL_SRC_FILES := libdispatch.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := objc
LOCAL_SRC_FILES := libobjc.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := gnustl_shared
LOCAL_SRC_FILES := libgnustl_shared.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := gnustep-base
LOCAL_SRC_FILES := libgnustep-base.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := gnustep-corebase
LOCAL_SRC_FILES := libgnustep-corebase.so
include $(PREBUILT_SHARED_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE    := CoreGraphics
LOCAL_SRC_FILES := libCoreGraphics.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := OpenGLES
LOCAL_SRC_FILES := libOpenGLES.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := CoreText
LOCAL_SRC_FILES := libCoreText.so
include $(PREBUILT_SHARED_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE    := QuartzCore
LOCAL_SRC_FILES := libQuartzCore.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := UIKit
LOCAL_SRC_FILES := libUIKit.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := NextBookKit
LOCAL_SRC_FILES := libNextBookKit.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := NextBookRun
LOCAL_SRC_FILES := libNextBookRun.so
include $(PREBUILT_SHARED_LIBRARY)
