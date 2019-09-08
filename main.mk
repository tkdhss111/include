RFLAGS += $(addprefix -I, $(DIRS_INC_RLS)) $(CFLAGS)
DFLAGS += $(addprefix -I, $(DIRS_INC_DBG)) $(CFLAGS)

.PHONY : all run debugrun release debug prep clean extra_clean install uninstall

all: prep release 

release: $(PATH_OBJS_RLS)
	$(FC) $(RFLAGS) -s -o $(PATH_EXE_RLS) $(PATH_OBJS_RLS) $(LIBS_RLS)

$(DIR_OBJ_RLS)%.o: %.f90
	$(FC) $(RFLAGS) -J$(DIR_OBJ_RLS) -o $@ -c $<

debug: $(PATH_OBJS_DBG)
	$(FC) $(DFLAGS) -o $(PATH_EXE_DBG) $(PATH_OBJS_DBG) $(LIBS_DBG)

$(DIR_OBJ_DBG)%.o: %.f90
	$(FC) $(DFLAGS) -J$(DIR_OBJ_DBG) -o $@ -c $< 

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
	chown jma:jma $(DIR_EXE_INS)$(DIR_PROJ)$(EXE)
	chown jma:jma /usr/bin/taketa_$(EXE)

uninstall:
	$(RM) $(DIR_EXE_INS)$(DIR_PROJ)$(EXE)
	$(RM) /usr/bin/taketa_$(EXE)
