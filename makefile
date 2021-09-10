#
# Entry makefile
#
# author: chetandev.ksd@gmail.com
#
# Overview: This is entry makefile where user can do following:
#  1) Create new projects
#  2) Trigger clean or incremental build
#
# This entry makefile can be copied to any location & there can be multiple
# entry makefiles in a workspace. Before you can use this entry makefile make
# sure following configuration is done:
# 
#

#
# Root path of the workspace
#
ROOT = .

#
# build output path
#
BUILD_PATH = $(ROOT)/proj/build

#
# project folder
#
PRJ_PATH = $(ROOT)/proj

#
# minbuild makefiles path
#
SCRIPT_PATH = $(ROOT)/src

#
# Defualt project
#
DEFAULT_PROJECT = afc

#
# assign default value for those variable not defined
#
ARGS ?= /home/pi/Documents/input.jpeg

#
# No Configuration allowed from here
#

#
# all makefile target
#
.PHONY: all
all: check_project
	@echo "### Running PREGEN"
	@$(MAKE) -f $(SCRIPT_PATH)/objgen.mk -s pregen PROJECT=$(PROJECT) PRJ_PATH=$(PRJ_PATH) BUILD_PATH=$(BUILD_PATH)
	@echo "### Running OBJGEN"
	@$(MAKE) -f $(SCRIPT_PATH)/objgen.mk -s all PROJECT=$(PROJECT) PRJ_PATH=$(PRJ_PATH) BUILD_PATH=$(BUILD_PATH)
	@echo "### Running POSTGEN"
	@$(MAKE) -f $(SCRIPT_PATH)/objgen.mk -s postgen PROJECT=$(PROJECT) PRJ_PATH=$(PRJ_PATH) BUILD_PATH=$(BUILD_PATH)

#
# run makefile target
#
run: check_project
	@echo "### Running Project Executable"
	@echo "==========================="
	@echo
	@$(BUILD_PATH)/$(PROJECT)/$(PROJECT).out $(ARGS)


#
# new makefile target
#
new:
ifndef PROJ
	$(error "### ERROR! PROJ not provided, unable to create new project")
else
	@echo "### Creating new project : $(PROJ)"
	@cp -r $(SCRIPT_PATH)/template $(PRJ_PATH)/$(PROJ)
	@mv $(PRJ_PATH)/$(PROJ)/template.cpp $(PRJ_PATH)/$(PROJ)/$(PROJ).cpp
	@echo "Done"
endif

#
# ressolve path of the project & check wheather target project
# has valid parameters
#
check_project: ressolve_project
	@echo "### Found project : $(PROJECT)"
	@mkdir -p $(BUILD_PATH)/$(PROJECT)

#
# ressolve target clean path
#
ressolve_clean_path:
ifdef PROJ
	$(eval TEMP = $(patsubst %/,%,$(PROJ)))
	$(eval PROJECT=$(TEMP))
	@echo "### Switching to requested project: $(PROJECT)"
ifeq ($(wildcard $(PRJ_PATH)/$(PROJ)/.),)
	$(error "### ERROR! Did not find project: $(PROJECT)")
endif
	@echo "### Found project : $(PROJECT)"
	$(eval CLEAN_PATH=$(BUILD_PATH)/$(PROJECT))
endif
ifndef PROJ
	@echo "### Cleaning entire build path"
	$(eval CLEAN_PATH=$(BUILD_PATH))
endif

#
# ressolve project path
#
# user can pass project name by assigning PROJ when calling make
# eg: make PROJ=test
# if user does not define PROJ when calling make, then DEFUALT_PROJECT
# will be selected as target project
#
ressolve_project: 
ifndef PROJ
	$(eval PROJECT=$(DEFAULT_PROJECT))
	@echo "### Switching to default project: $(PROJECT)"
ifeq ($(wildcard $(PRJ_PATH)/$(DEFAULT_PROJECT)/.),)
	$(error "### ERROR! Did not find project: $(DEFAULT_PROJECT)")
endif
endif
ifdef PROJ
	$(eval TEMP = $(patsubst %/,%,$(PROJ)))
	$(eval PROJECT=$(TEMP))
	@echo "### Switching to requested project: $(PROJECT)"
ifeq ($(wildcard $(PRJ_PATH)/$(PROJ)/.),)
	$(error "### ERROR! Did not find project: $(PROJ)")
endif
endif


#
# clean target
#
# used to completely clean build folder
#
.PHONY: clean

clean: ressolve_clean_path
	@echo
	rm -rf $(CLEAN_PATH)/*
	@echo "=== content of build ==="
	ls -l $(CLEAN_PATH)
	@echo


