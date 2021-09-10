#
# OBJGEN makefile
#
# author: chetandev.ksd@gmail.com
#

#
# Objgen makefiile requires three input
# PRJ_PATH -> define path of solution (solution has multiple projects)
# PROJECT -> define project name
# BUILD_PATH -> define build output path
#
ifndef PROJECT
	$(error "PROJECT not defined")
endif

ifndef BUILD_PATH
	$(error "BUILD_PATH not defined")
endif

ifndef PRJ_PATH
	$(error "PRJ_PATH not defined")
endif

#
# get objgen.mk path
#
TEMP := $(abspath $(lastword $(MAKEFILE_LIST)))
SCRIPT_PATH := $(notdir $(patsubst %/,%,$(dir $(TEMP))))

#
# Import external scripts
#
include $(SCRIPT_PATH)/extralib.mk
include $(SCRIPT_PATH)/common.mk
include $(PRJ_PATH)/$(PROJECT)/config.mk

#
# assign environmental variable VPATH
#
# subdirectories of all source file to be compiled
# will be automatically found and assigned to VPATH
#
VPATH := $(dir $(PROJECT_SRC))

#
# get project specific build directory and executable name
#
PROJ_BUILD = $(BUILD_PATH)/$(PROJECT)
PROJ_EXEC  = $(PROJ_BUILD)/$(PROJECT)

#
# Reconcile external script variables
#
CFLAGS  = $(COMMON_CFLAG)
CFLAGS += $(COMMON_IPATH:%=-I%)
CFLAGS += $(PROJECT_CFLAG)
CFLAGS += $(PROJECT_IPATH:%=-I%)
CFLAGS += $(PROJECT_DEF:%=-D%)

LFLAGS  = $(COMMON_LFLAG)
LFLAGS += $(PROJECT_LFLAG)

#
# PREGEN & POSTGEN targets
#

pregen: $(PROJECT_PREGEN)
ifeq ($(strip $(PROJECT_PREGEN)),)
	@echo "No pregen targets to be executed"
else
	@echo "Done executing pregen targets"
endif
	

postgen: $(PROJECT_POSTGEN)
ifeq ($(strip $(PROJECT_POSTGEN)),)
	@echo "No postgen targets to be executed"
else
	@echo "Done executing postgen targets"
endif
	@echo "Build Complete!"

#
# find absoulte paths
#
ABSPATH_SRC_FILES    := $(realpath $(PROJECT_SRC))
ABSPATH_PROJECY_DEP  := $(realpath $(PROJECT_DEP))

#
# generate file compilation target
#
ABSPATH_SRC_FILES  := $(realpath $(PROJECT_SRC))
TEMP := $(patsubst %.cpp,%_cpp.o,$(PROJECT_SRC))
TEMP := $(patsubst %.c,%_c.o,$(TEMP))
TEMP := $(patsubst %.S,%_S.o,$(TEMP))
OBJECT_FILES := $(foreach FILE, $(TEMP), $(BUILD_PATH)/$(PROJECT)/$(notdir $(FILE)))



#
# all makefile target
#

.PHONY: all
all: $(OBJECT_FILES)
	@echo "### Running Linker"
	@g++ $(LFLAGS) -Wl,-Map,"$(PROJ_EXEC).map" -o"$(PROJ_EXEC).out" $(PROJ_BUILD)/*.o
	@echo "================================================="
	@size $(PROJ_EXEC).out
	@echo "================================================="

$(PROJ_BUILD)/%_cpp.o: %.cpp
	@echo "Compiling [C++] file $< to $@"
	@g++ $(CFLAGS) $< -o $@

$(PROJ_BUILD)/%_c.o : %.c
	@echo "Compiling [C  ] file $< to $@"
	@gcc $(CFLAGS) $< -o $@

$(PROJ_BUILD)/%_S.o : %.S
	@echo "Compiling [Asm] file $< to $@"
	@gcc $(CFLAGS) $< -o $@