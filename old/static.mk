#=============================================================                           
# Makefile for Fortran static library
#
# Created by: Hisashi Takeda, Ph.D. 2019-02-05
#=============================================================

LIB           := lib$(NAME).a
PATH_LIB_RLS  := $(addprefix $(DIR_LIB_RLS), $(LIB))
PATH_LIB_DBG  := $(addprefix $(DIR_LIB_DBG), $(LIB))

PATH_OBJS_RLS := $(addprefix $(DIR_OBJ_RLS), $(OBJS))
PATH_OBJS_DBG := $(addprefix $(DIR_OBJ_DBG), $(OBJS))

RFLAGS += $(CFLAGS)
DFLAGS += $(CFLAGS)

.PHONY : all run debugrun release debug prep clean extra_clean install uninstall

defalut: release 

release: prep_release $(PATH_OBJS_RLS)
	$(AR) $(PATH_LIB_RLS) $(PATH_OBJS_RLS)
	$(RM) $(DIR_LIB_RLS)*.o

$(DIR_OBJ_RLS)%.o: %.$(EXT)
	$(FC) $(RFLAGS) -J$(DIR_OBJ_RLS) -o $@ -c $<

debug: prep_debug $(PATH_OBJS_DBG)
	$(AR) $(PATH_LIB_DBG) $(PATH_OBJS_DBG)

$(DIR_OBJ_DBG)%.o: %.$(EXT)
	$(FC) $(DFLAGS) -J$(DIR_OBJ_DBG) -o $@ -c $< 

prep_release:
	$(MKDIR) $(DIR_OBJ_RLS) $(DIR_BIN_RLS)

prep_debug:
	$(MKDIR) $(DIR_OBJ_DBG) $(DIR_BIN_DBG)

clean: clean_release clean_debug

clean_release:
	$(RM) $(PATH_LIB_RLS)
	$(RM) $(DIR_LIB_RLS)*.*

clean_debug:
	$(RM) $(PATH_LIB_DBG)
	$(RM) $(DIR_LIB_DBG)*.*

extra_clean:
	$(RM)r $(PATH_LIB_RLS) $(PATH_LIB_DBG)

install:
	$(MKDIR) $(DIR_LIB_INS)$(NAME)
	$(CP) $(DIR_LIB_RLS)$(LIB) $(DIR_LIB_INS)$(NAME)/
	$(CP) $(DIR_LIB_RLS)*.mod $(DIR_LIB_INS)$(NAME)/

uninstall:
	$(RM)r $(DIR_LIB_INS)$(NAME)
