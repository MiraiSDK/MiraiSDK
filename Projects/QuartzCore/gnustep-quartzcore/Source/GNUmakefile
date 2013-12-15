
ifeq ($(GNUSTEP_MAKEFILES),)
  GNUSTEP_MAKEFILES := $(shell gnustep-config --variable=GNUSTEP_MAKEFILES 2>/dev/null)
  ifeq ($(GNUSTEP_MAKEFILES),)
    $(error You need to set GNUSTEP_MAKEFILES before compiling!)
  endif
endif

include $(GNUSTEP_MAKEFILES)/common.make


PACKAGE_NAME = quartzcore
LIBRARY_NAME = libQuartzCore

# Include configuration

-include ../config.make

libQuartzCore_OBJCFLAGS += -std=c99
libQuartzCore_HEADER_FILES_DIR = ../Headers/QuartzCore
libQuartzCore_HEADER_FILES_INSTALL_DIR = QuartzCore

libQuartzCore_HEADER_FILES = \
	AppleSupport.h \
	AppleSupportRevert.h \
	CAAction.h \
	CAAnimation.h \
	CABase.h \
	CADisplayLink.h \
	CAEAGLLayer.h \
	CAGradientLayer.h \
	CALayer.h \
	CAMediaTimingFunction.h \
	CAMediaTiming.h \
	CARenderer.h \
	CAReplicatorLayer.h \
	CAScrollLayer.h \
	CAShapeLayer.h \
	CATextLayer.h \
	CATiledLayer.h \
	CATransaction.h \
	CATransform3D.h \
	CATransformLayer.h \
	CAValueFunction.h \
	CoreAnimation.h \
	QuartzCore.h
libQuartzCore_RESOURCE_FILES = \
	$(wildcard Shaders/*.vsh) \
	$(wildcard Shaders/*.fsh)

libQuartzCore_OBJC_FILES = $(wildcard *.m) $(wildcard GLHelpers/*.m)

libQuartzCore_OBJCFLAGS += -DANDROID
libQuartzCore_OBJCFLAGS += $(WARN_FLAGS) 

LIBRARIES_DEPEND_UPON += -lopal -lgnustep-base -lGLESv2 -lgnustl_shared -lobjc -lm

# Treat warnings as errors unless someone chooses to ignore them.
#ifneq ($(nonstrict), yes)
#QuartzCore_OBJCFLAGS += -Werror
#endif

-include ../GNUmakefile.preamble
#include $(GNUSTEP_MAKEFILES)/framework.make
include $(GNUSTEP_MAKEFILES)/library.make

-include GNUmakefile.postamble
