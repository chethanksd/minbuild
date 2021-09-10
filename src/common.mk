#
# Common definitions
#
# author: chetandev.ksd@gmail.com
#


#
# Include serach paths
#
COMMON_IPATH  += 

#
# Common defines
#
COMMON_DEF  +=


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
COMMON_LFLAG += -Wl,--gc-sections
