#=============================================================                           
# Makefile for Fortran static library
#
# Created by: Hisashi Takeda, Ph.D. 2019-02-05
#=============================================================

LIB           := lib$(NAME).a
MODS          := $(SRCS:%mo.f90=%mo.mod)
PATH_LIB_RLS  := $(addprefix $(DIR_LIB_RLS), $(LIB))
PATH_LIB_DBG  := $(addprefix $(DIR_LIB_DBG), $(LIB))

RFLAGS += $(addprefix -I, $(DIRS_INC_RLS)) $(CFLAGS)
DFLAGS += $(addprefix -I, $(DIRS_INC_DBG)) $(CFLAGS)

.PHONY : all run debugrun release debug prep clean extra_clean install uninstall

all : prep release 

release: $(PATH_OBJS_RLS)
	$(AR)s $(PATH_LIB_RLS) $(PATH_OBJS_RLS)
	$(RM) $(DIR_LIB_RLS)*.o

$(DIR_OBJ_RLS)%.o: %.f90
	$(FC) $(RFLAGS) -J$(DIR_OBJ_RLS) -o $@ -c $<

debug: $(PATH_OBJS_DBG)
	$(AR)s $(PATH_LIB_DBG) $(PATH_OBJS_DBG)

$(DIR_OBJ_DBG)%.o: %.f90
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
