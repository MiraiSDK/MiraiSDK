
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
LOCAL_MODULE    := opal
LOCAL_SRC_FILES := libopal.so
include $(PREBUILT_SHARED_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE    := BasicCairo
LOCAL_SRC_FILES := libBasicCairo.so
include $(PREBUILT_SHARED_LIBRARY)

