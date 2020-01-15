FC            := caf 
DIR_PROJS     := /home/jma/1_Projects/
DIR_TOOLS     := /home/jma/2_Tools/
DIR_DATA      := /home/jma/3_Data/
DIR_BIN_INS   := /usr/bin/fortran/
DIR_LIB_INS   := /usr/lib/fortran/
DIR_BIN_RLS   := $(DIR_PROJS)$(DIR_PROJ)bin/Release/
DIR_BIN_DBG   := $(DIR_PROJS)$(DIR_PROJ)bin/Debug/
DIR_LIB_RLS   := $(DIR_PROJS)$(DIR_PROJ)lib/Release/
DIR_LIB_DBG   := $(DIR_PROJS)$(DIR_PROJ)lib/Debug/
DIR_OBJ_RLS   := $(DIR_PROJS)$(DIR_PROJ)obj/Release/$(NAME)/
DIR_OBJ_DBG   := $(DIR_PROJS)$(DIR_PROJ)obj/Debug/$(NAME)/

OBJS          := $(SRCS:.f90=.o)

PATH_BIN_RLS  := $(addprefix $(DIR_BIN_RLS), $(NAME))
PATH_BIN_DBG  := $(addprefix $(DIR_BIN_DBG), $(NAME))
PATH_OBJS_RLS := $(addprefix $(DIR_OBJ_RLS), $(OBJS))
PATH_OBJS_DBG := $(addprefix $(DIR_OBJ_DBG), $(OBJS))

CP            := cp
LN            := ln -s
RM            := rm -f
MKDIR         := @mkdir -p
AR            := ar -rv
CFLAGS        := -cpp -ffree-line-length-none -fopenmp -fdec-math -mcmodel=large -pthread
RFLAGS        := -O3 -march=native -Drelease
DFLAGS        := -g -Wall -Wextra -fcheck=all -fcheck=bounds -Ddebug
LFLAGS        := -static -s
