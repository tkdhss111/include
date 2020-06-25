USR           := jma
ID_PROG       := enecast
DIR_HOME      := /home/$(USR)/
DIR_PROJS     := $(DIR_HOME)1_Projects/
DIR_TOOLS     := $(DIR_HOME)2_Tools/
DIR_DATA      := $(DIR_HOME)3_Data/
DIR_BIN_INS   := /usr/bin/taketa_gfortran/$(ID_PROG)/
DIR_LIB_INS   := /usr/lib/taketa_gfortran/$(ID_PROG)/
DIR_BIN_RLS   := $(DIR_PROJS)$(DIR_PROJ)bin/Release/
DIR_BIN_DBG   := $(DIR_PROJS)$(DIR_PROJ)bin/Debug/
DIR_LIB_RLS   := $(DIR_PROJS)$(DIR_PROJ)lib/Release/
DIR_LIB_DBG   := $(DIR_PROJS)$(DIR_PROJ)lib/Debug/
DIR_OBJ_RLS   := $(DIR_PROJS)$(DIR_PROJ)obj/Release/$(NAME)/
DIR_OBJ_DBG   := $(DIR_PROJS)$(DIR_PROJ)obj/Debug/$(NAME)/
PATH_BIN_RLS  := $(addprefix $(DIR_BIN_RLS), $(NAME))
PATH_BIN_DBG  := $(addprefix $(DIR_BIN_DBG), $(NAME))

FC            := caf
CC            := gcc
CP            := cp
LN            := ln -s
RM            := rm -f
MKDIR         := mkdir -p
AR            := ar
AARGS         := -rcsv
CFLAGS        := -cpp -ffree-line-length-none -fopenmp -fdec-math -mcmodel=large -pthread
RFLAGS        := -O3 -Drelease -Wall -Wextra -Wno-maybe-uninitialized
DFLAGS        := -g -Wall -Wextra -fcheck=all -fcheck=bounds -Ddebug -Wno-maybe-uninitialized -Wno-uninitialized
#DFLAGS        := -g -Wall -Wextra -fcheck=all -fcheck=bounds -Ddebug -Wno-unused -Wno-maybe-uninitialized -Wno-uninitialized
LFLAGS        := -static -s
EXT           := f90
OP_DIR_OBJ    := -J# gfortran
