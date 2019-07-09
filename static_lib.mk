#=============================================================                           
# Makefile for Fortran static library
#
# Created by: Hisashi Takeda, Ph.D. 2019-02-05
#=============================================================

FC            := gfortran-9
DIR_PROJS     := /home/jma/1_Projects/
DIR_TOOLS     := /home/jma/2_Tools/
DIR_DATA      := /home/jma/3_Data/
DIRS_INC      := $(DIR_PROJS)$(DIR_PROJ)lib/Release/
DIR_LIB_INS   := /usr/lib/fortran/$(FC)/
DIR_LIB_RLS   := $(DIR_PROJS)$(DIR_PROJ)lib/Release/
DIR_LIB_DBG   := $(DIR_PROJS)$(DIR_PROJ)lib/Debug/
DIR_OBJ_RLS   := $(DIR_PROJS)$(DIR_PROJ)lib/Release/
DIR_OBJ_DBG   := $(DIR_PROJS)$(DIR_PROJ)lib/Debug/
LIB           := lib$(NAME).a
OBJS          := $(SRCS:%.f90=%.o)
MODS          := $(SRCS:%mo.f90=%mo.mod)
PATH_LIB_RLS  := $(addprefix $(DIR_LIB_RLS), $(LIB))
PATH_LIB_DBG  := $(addprefix $(DIR_LIB_DBG), $(LIB))
PATH_OBJS_RLS := $(addprefix $(DIR_OBJ_RLS), $(OBJS))
PATH_OBJS_DBG := $(addprefix $(DIR_OBJ_DBG), $(OBJS))
CP            := cp
RM            := rm -f
MKDIR         := mkdir -p
LD            := ar -rv
CFLAGS        := -cpp -ffree-line-length-none -fopenmp -fdec-math $(addprefix -I, $(DIRS_INC))
RFLAGS        := -O3 -march=native -Drelease $(CFLAGS)
DFLAGS        := -g -Wall -Wextra -fcheck=all -fcheck=bounds -Ddebug $(CFLAGS)
LFLAGS        := -static -s

.PHONY : all run debugrun release debug prep clean extra_clean install uninstall

all : prep release 

run: $(PATH_OBJS_RLS)
	$(LD)s $(PATH_LIB_RLS) $(PATH_OBJS_RLS)
	$(RM) $(DIR_LIB_RLS)*.o

debugrun: $(PATH_OBJS_DBG)
	$(LD)s $(PATH_LIB_DBG) $(PATH_OBJS_DBG)

release: $(PATH_OBJS_RLS)
	$(LD)s $(PATH_LIB_RLS) $(PATH_OBJS_RLS)
	$(RM) $(DIR_LIB_RLS)*.o

$(DIR_OBJ_RLS)%.o: %.f90 $(addprefix $(DIR_OBJ_DBG), file_mo.o string_helpers.o tb_mo.o)
	$(FC) $(RFLAGS) -J$(DIR_OBJ_RLS) -o $@ -c $<

debug: $(PATH_OBJS_DBG)
	$(LD)s $(PATH_LIB_DBG) $(PATH_OBJS_DBG)

$(DIR_OBJ_DBG)%.o: %.f90 $(addprefix $(DIR_OBJ_DBG), file_mo.o string_helpers.o tb_mo.o)
	$(FC) $(DFLAGS) -J$(DIR_OBJ_DBG) -o $@ -c $< 

prep:
	$(MKDIR) $(DIR_OBJ_RLS) $(DIR_OBJ_DBG) $(DIR_LIB_RLS) $(DIR_LIB_DBG)

clean:
	$(RM) $(PATH_LIB_RLS)
	$(RM) $(DIR_OBJ_RLS)*.*
	$(RM) $(PATH_LIB_DBG)
	$(RM) $(DIR_OBJ_DBG)*.*

clean_release:
	$(RM) $(PATH_LIB_RLS)
	$(RM) $(DIR_OBJ_RLS)*.*

clean_debug:
	$(RM) $(PATH_LIB_DBG)
	$(RM) $(DIR_OBJ_DBG)*.*

extra_clean:
	$(RM)r $(PATH_LIB_RLS) $(PATH_LIB_DBG) $(DIR_OBJ_RLS) $(DIR_OBJ_DBG)

install:
	$(MKDIR) $(DIR_LIB_INS)$(NAME)
	$(CP) $(DIR_LIB_RLS)$(LIB) $(DIR_LIB_INS)$(NAME)/
	$(CP) $(DIR_LIB_RLS)*.mod $(DIR_LIB_INS)$(NAME)/

uninstall:
	$(RM)r $(DIR_LIB_INS)$(NAME)

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

