ifeq ($(SIMULATOR),1)
	export ARCHS = arm64 x86_64
	export TARGET = simulator:clang::15.0
else
	export ARCHS = arm64 arm64e
	export TARGET = iphone:latest:15.0
endif

include $(THEOS)/makefiles/common.mk

# Build this FLEX source tree as a normal libFLEX dylib package.
FLEX_ROOT = .

# Function to convert /foo/bar to -I/foo/bar
flex_imports = $(foreach d,$(1),-I$(d))

SOURCES  = $(shell find $(FLEX_ROOT)/Classes -name '*.c')
SOURCES += $(shell find $(FLEX_ROOT)/Classes -name '*.m')
SOURCES += $(shell find $(FLEX_ROOT)/Classes -name '*.mm')

_IMPORTS  = $(shell /bin/ls -d $(FLEX_ROOT)/Classes/*/ 2>/dev/null)
_IMPORTS += $(shell /bin/ls -d $(FLEX_ROOT)/Classes/*/*/ 2>/dev/null)
_IMPORTS += $(shell /bin/ls -d $(FLEX_ROOT)/Classes/*/*/*/ 2>/dev/null)
_IMPORTS += $(shell /bin/ls -d $(FLEX_ROOT)/Classes/*/*/*/*/ 2>/dev/null)
IMPORTS = -I$(FLEX_ROOT)/Classes/ $(call flex_imports,$(_IMPORTS))

LIBRARY_NAME = libFLEX
$(LIBRARY_NAME)_FILES = libFLEX.x $(SOURCES)
$(LIBRARY_NAME)_FRAMEWORKS = Foundation UIKit CoreGraphics ImageIO QuartzCore WebKit Security SceneKit
$(LIBRARY_NAME)_LIBRARIES = sqlite3 z c++
$(LIBRARY_NAME)_CFLAGS += -fobjc-arc -w -Wno-unsupported-availability-guard -Wno-deprecated-declarations $(IMPORTS) -g
$(LIBRARY_NAME)_CCFLAGS += -std=gnu++11

include $(THEOS_MAKE_PATH)/library.mk

before-stage::
	find . -name ".DS_Store" -delete

print-%  : ; @echo $* = $($*)
