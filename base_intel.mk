ID_PROG       := enecast
USR           := jma
DIR_PROJS     := /home/jma/1_Projects/
DIR_TOOLS     := /home/jma/2_Tools/
DIR_DATA      := /home/jma/3_Data/
DIR_BIN_INS   := /usr/bin/$(ID_PROG)/
DIR_LIB_INS   := /usr/lib/$(ID_PROG)/
DIR_BIN_RLS   := $(DIR_PROJS)$(DIR_PROJ)bin/Release/
DIR_BIN_DBG   := $(DIR_PROJS)$(DIR_PROJ)bin/Debug/
DIR_LIB_RLS   := $(DIR_PROJS)$(DIR_PROJ)lib/Release/
DIR_LIB_DBG   := $(DIR_PROJS)$(DIR_PROJ)lib/Debug/
DIR_OBJ_RLS   := $(DIR_PROJS)$(DIR_PROJ)obj/Release/$(NAME)/
DIR_OBJ_DBG   := $(DIR_PROJS)$(DIR_PROJ)obj/Debug/$(NAME)/
PATH_BIN_RLS  := $(addprefix $(DIR_BIN_RLS), $(NAME))
PATH_BIN_DBG  := $(addprefix $(DIR_BIN_DBG), $(NAME))

FC            := ifort
CC            := ic
CP            := cp
LN            := ln -s
RM            := rm -f
MKDIR         := @mkdir -p
AR            := xiar
AARGS         := -rcsv
CFLAGS        := -Dintel -fpp -mcmodel=large -pthread -heap-arrays
RFLAGS        := -O3 -march=native -Drelease -parallel
DFLAGS        := -g -debug full -Ddebug
LFLAGS        := -static-intel 
EXT           := f90
OP_DIR_OBJ    := -module

# intel
#source /opt/intel/compilers_and_libraries/linux/bin/compilervars.sh -arch intel64 -platform linux
