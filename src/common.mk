#
# Common definitions
#
# author: chetandev.ksd@gmail.com
#

#
# Common makefile definitons
#
LIB_DIR = $(ROOT)/lib


#
# Include serach paths
#
COMMON_IPATH  = $(LIB_DIR)
COMMON_IPATH += /usr/local/include/opencv4/


#
# Compile options
#
COMMON_CFLAG  = -ffunction-sections
COMMON_CLFAG += -fdata-sections 
COMMON_CFLAG += -Wall
COMMON_CFLAG += -g -ggdb -gdwarf-3 -gstrict-dwarf
COMMON_CFLAG += -c
COMMON_CFLAG += -Os

#
# Linker options
#
COMMON_LFLAG  = -L/usr/local/lib
COMMON_LFLAG += -Wl,--gc-sections
