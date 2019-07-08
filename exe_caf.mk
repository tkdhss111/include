# Last updated: 2019-07-06 10:12:41.
#=============================================================                           
# Common makefile definitions for Fortran
#
# Created by: Hisashi Takeda, Ph.D. 2019-02-05
#=============================================================

FC            := gfortran-9
DIR_PROJS     := /home/eric/1_Projects/
DIR_TOOLS     := /home/eric/2_Tools/
DIR_DATA      := /home/eric/3_Data/
DIR_EXE_INS   := /usr/bin/fortran/$(FC)/
DIR_EXE_RLS   := $(DIR_PROJS)$(DIR_PROJ)bin/Release/
DIR_EXE_DBG   := $(DIR_PROJS)$(DIR_PROJ)bin/Debug/
DIR_OBJ_RLS   := $(DIR_PROJS)$(DIR_PROJ)obj/Release/$(EXE)/# To avoid main.o conflictions, use separated folders.
DIR_OBJ_DBG   := $(DIR_PROJS)$(DIR_PROJ)obj/Debug/$(EXE)/
DIRS_INC_RLS  := $(DIR_PROJS)utils/lib/Release/
DIRS_INC_DBG  := $(DIR_PROJS)utils/lib/Debug/
LIBS_RLS      := $(DIR_PROJS)utils/lib/Release/libutils.a -lcaf_mpi
LIBS_DBG      := $(DIR_PROJS)utils/lib/Debug/libutils.a -lcaf_mpi
OBJS          := $(SRCS:.f90=.o)
PATH_EXE_RLS  := $(addprefix $(DIR_EXE_RLS), $(EXE))
PATH_EXE_DBG  := $(addprefix $(DIR_EXE_DBG), $(EXE))
PATH_OBJS_RLS := $(addprefix $(DIR_OBJ_RLS), $(OBJS))
PATH_OBJS_DBG := $(addprefix $(DIR_OBJ_DBG), $(OBJS))
CP            := cp
LN            := ln -s
RM            := rm -f
MKDIR         := @mkdir -p
LD            := ar -rv
CFLAGS        := -cpp -ffree-line-length-none -fopenmp -fcoarray=lib
RFLAGS        := -O3 -march=native -Drelease $(addprefix -I, $(DIRS_INC_RLS)) $(CFLAGS)
DFLAGS        := -g -Wall -Wextra -fcheck=all -fcheck=bounds -Ddebug $(addprefix -I, $(DIRS_INC_DBG)) $(CFLAGS)
LFLAGS        := -static -s

.PHONY : all run debugrun release debug prep clean extra_clean install uninstall

all: prep release 

release: $(PATH_OBJS_RLS)
	$(FC) $(RFLAGS) -s -o $(PATH_EXE_RLS) $(PATH_OBJS_RLS) $(LIBS_RLS)

$(DIR_OBJ_RLS)%.o: %.f90
	$(FC) $(RFLAGS) -J $(DIR_OBJ_RLS) -o $@ -c $<

debug: $(PATH_OBJS_DBG)
	$(FC) $(DFLAGS) -o $(PATH_EXE_DBG) $(PATH_OBJS_DBG) $(LIBS_DBG)

$(DIR_OBJ_DBG)%.o: %.f90
	$(FC) $(DFLAGS) -J $(DIR_OBJ_DBG) -o $@ -c $< 

debugrun: prep debug
	$(DIR_PROJS)$(DIR_PROJ)bin/Debug/$(EXE)

prep:
	$(MKDIR) $(DIR_OBJ_RLS) $(DIR_OBJ_DBG) $(DIR_EXE_RLS) $(DIR_EXE_DBG)

clean:
	$(RM) $(PATH_EXE_RLS)
	$(RM) $(DIR_OBJ_RLS)*.*
	$(RM) $(PATH_EXE_DBG)
	$(RM) $(DIR_OBJ_DBG)*.*

clean_release:
	$(RM) $(PATH_EXE_RLS)
	$(RM) $(DIR_OBJ_RLS)*.*

clean_debug:
	$(RM) $(PATH_EXE_DBG)
	$(RM) $(DIR_OBJ_DBG)*.*

extra_clean:
	$(RM)r $(PATH_EXE_RLS) $(PATH_EXE_DBG) $(DIR_OBJ_RLS) $(DIR_OBJ_DBG)

install:
	$(MKDIR) $(DIR_EXE_INS)$(DIR_PROJ)
	$(CP) $(DIR_EXE_RLS)$(EXE) $(DIR_EXE_INS)$(DIR_PROJ)$(EXE)
	$(RM) /usr/bin/taketa_$(EXE)
	$(LN) $(DIR_EXE_INS)$(DIR_PROJ)$(EXE) /usr/bin/taketa_$(EXE)
	chown eric:eric $(DIR_EXE_INS)$(DIR_PROJ)$(EXE)
	chown eric:eric /usr/bin/taketa_$(EXE)

uninstall:
	$(RM) $(DIR_EXE_INS)$(DIR_PROJ)$(EXE)
	$(RM) /usr/bin/taketa_$(EXE)

# Makefiles 	
#
#    Use # for comments in Makefiles.
#
#    Write rules as target: dependencies.
#
#    Specify update actions in a tab-indented block under the rule.
#
#    Use .PHONY to mark targets that don’t correspond to files.
#
#Automatic Variables 	
#
#    Use $@ to refer to the target of the current rule.
#
#    Use $^ to refer to the dependencies of the current rule.
#
#    Use $< to refer to the first dependency of the current rule.
#
#Dependencies on Data and Code 	
#
#    Make results depend on processing scripts as well as data files.
#
#    Dependencies are transitive: if A depends on B and B depends on C, a change to C will indirectly trigger an update to A.
#
#Pattern Rules 	
#
#    Use the wildcard % as a placeholder in targets and dependencies.
#
#    Use the special variable $* to refer to matching sets of files in actions.
#
#Variables 	
#
#    Define variables by assigning values to names.
#
#    Reference variables using $(...).
#
#Functions 	
#
#    Make is actually a small programming language with many built-in functions.
#
#    Use wildcard function to get lists of files matching a pattern.
#
#    Use patsubst function to rewrite file names.

