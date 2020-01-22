RFLAGS += $(CFLAGS) $(addprefix -I, $(DIRS_INC_RLS))
DFLAGS += $(CFLAGS) $(addprefix -I, $(DIRS_INC_DBG))

.PHONY : all run debugrun release debug prep clean extra_clean install uninstall

all: prep release 

release: $(PATH_OBJS_RLS)
	$(FC) $(RFLAGS) -s -o $(PATH_BIN_RLS) $(PATH_OBJS_RLS) $(LIBS_RLS)

$(DIR_OBJ_RLS)%.o: %.f90
	$(FC) $(RFLAGS) -J$(DIR_OBJ_RLS) -o $@ -c $<

debug: $(PATH_OBJS_DBG)
	$(FC) $(DFLAGS) -o $(PATH_BIN_DBG) $(PATH_OBJS_DBG) $(LIBS_DBG)

$(DIR_OBJ_DBG)%.o: %.f90
	$(FC) $(DFLAGS) -J$(DIR_OBJ_DBG) -o $@ -c $<

debugrun: prep debug
	$(DIR_PROJS)$(DIR_PROJ)bin/Debug/$(NAME)

prep:
	$(MKDIR) $(DIR_OBJ_RLS) $(DIR_OBJ_DBG) $(DIR_BIN_RLS) $(DIR_BIN_DBG)

clean:
	$(RM) $(PATH_BIN_RLS)
	$(RM) $(DIR_OBJ_RLS)*.*
	$(RM) $(PATH_BIN_DBG)
	$(RM) $(DIR_OBJ_DBG)*.*

clean_release:
	$(RM) $(PATH_BIN_RLS)
	$(RM) $(DIR_OBJ_RLS)*.*

clean_debug:
	$(RM) $(PATH_BIN_DBG)
	$(RM) $(DIR_OBJ_DBG)*.*

extra_clean:
	$(RM)r $(PATH_BIN_RLS) $(PATH_BIN_DBG) $(DIR_OBJ_RLS) $(DIR_OBJ_DBG)

install:
	$(MKDIR) $(DIR_BIN_INS)$(DIR_PROJ)
	$(CP) $(DIR_BIN_RLS)$(NAME) $(DIR_BIN_INS)$(DIR_PROJ)$(NAME)
	$(RM) /usr/bin/$(USR)_$(NAME)
	$(LN) $(DIR_BIN_INS)$(DIR_PROJ)$(NAME) /usr/bin/$(USR)_$(NAME)
	chown $(USR):$(USR) $(DIR_BIN_INS)$(DIR_PROJ)$(NAME)
	chown $(USR):$(USR) /usr/bin/$(USR)_$(NAME)

uninstall:
	$(RM) $(DIR_BIN_INS)$(DIR_PROJ)$(NAME)
	find $(DIR_BIN_INS) -type d -empty -delete
	$(RM) /usr/bin/$(USR)_$(NAME)
