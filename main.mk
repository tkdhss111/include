OBJS          := $(SRCS:.$(EXT)=.o)
PATH_OBJS_RLS := $(addprefix $(DIR_OBJ_RLS), $(OBJS))
PATH_OBJS_DBG := $(addprefix $(DIR_OBJ_DBG), $(OBJS))

RFLAGS += $(CFLAGS) $(addprefix -I, $(DIRS_INC_RLS))
DFLAGS += $(CFLAGS) $(addprefix -I, $(DIRS_INC_DBG))

.PHONY : all run debugrun release debug prep clean extra_clean install uninstall

default: release 

static: prep release $(PATH_OBJS_RLS)
	$(AR) $(AARGS) $(DIR_PROJS)$(DIR_PROJ)lib$(DIR_PROJ:/=.a) $(addprefix $(DIR_OBJ_RLS), $(NAME)_mo.o) && \
	$(AR) t $(DIR_PROJS)$(DIR_PROJ)lib$(DIR_PROJ:/=.a)

release: prep_release $(PATH_OBJS_RLS)
	$(FC) $(RFLAGS) -s -o $(PATH_BIN_RLS) $(PATH_OBJS_RLS) $(LIBS_RLS)

$(DIR_OBJ_RLS)%.o: %.$(EXT)
	$(FC) $(RFLAGS) -J$(DIR_OBJ_RLS) -o $@ -c $<

debug: prep_debug $(PATH_OBJS_DBG)
	$(FC) $(DFLAGS) -o $(PATH_BIN_DBG) $(PATH_OBJS_DBG) $(LIBS_DBG)

$(DIR_OBJ_DBG)%.o: %.$(EXT)
	$(FC) $(DFLAGS) -J$(DIR_OBJ_DBG) -o $@ -c $<

debugrun: prep_debug debug
	$(DIR_PROJS)$(DIR_PROJ)$(NAME)/bin/Debug/$(NAME)

prep_release:
	$(MKDIR) $(DIR_OBJ_RLS) $(DIR_BIN_RLS)

prep_debug:
	$(MKDIR) $(DIR_OBJ_DBG) $(DIR_BIN_DBG)

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
	$(RM) /usr/bin/$(ID_PROG)_$(NAME)
	$(LN) $(DIR_BIN_INS)$(DIR_PROJ)$(NAME) /usr/bin/$(ID_PROG)_$(NAME)
	chown $(USR):$(USR) $(DIR_BIN_INS)$(DIR_PROJ)$(NAME)
	chown $(USR):$(USR) /usr/bin/$(ID_PROG)_$(NAME)

uninstall:
	$(RM) $(DIR_BIN_INS)$(DIR_PROJ)$(NAME)
	find $(DIR_BIN_INS) -type d -empty -delete
	$(RM) /usr/bin/$(ID_PROG)_$(NAME)
