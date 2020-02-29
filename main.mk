OBJS          := $(SRCS:.$(EXT)=.o)
PATH_OBJS_RLS := $(addprefix $(DIR_OBJ_RLS), $(OBJS))
PATH_OBJS_DBG := $(addprefix $(DIR_OBJ_DBG), $(OBJS))

RFLAGS += $(CFLAGS) $(addprefix -I, $(DIRS_INC_RLS))
DFLAGS += $(CFLAGS) $(addprefix -I, $(DIRS_INC_DBG))

DIR_LIB_RLS := $(DIR_PROJS)$(DIR_PROJ)lib/Release/
DIR_LIB_DBG := $(DIR_PROJS)$(DIR_PROJ)lib/Debug/

.PHONY : default
default: release 

.PHONY : lib
lib: lib_release lib_debug

.PHONY : lib_release
lib_release: release $(PATH_OBJS_RLS)
	$(AR) $(AARGS) $(DIR_LIB_RLS)lib$(DIR_PROJ:/=.a) $(filter-out %/main.o, $(PATH_OBJS_RLS)) && \
	$(CP) $(wildcard $(DIR_OBJ_RLS)*mod) $(DIR_LIB_RLS) && \
	$(AR) t $(DIR_LIB_RLS)lib$(DIR_PROJ:/=.a)

.PHONY : lib_debug
lib_debug: debug $(PATH_OBJS_DBG)
	$(AR) $(AARGS) $(DIR_LIB_DBG)lib$(DIR_PROJ:/=.a) $(filter-out %/main.o, $(PATH_OBJS_DBG)) && \
	$(CP) $(wildcard $(DIR_OBJ_DBG)*mod) $(DIR_LIB_DBG) && \
	$(AR) t $(DIR_LIB_DBG)lib$(DIR_PROJ:/=.a)

.PHONY : release
release: prep_release $(PATH_OBJS_RLS)
	$(FC) $(RFLAGS) -s -o $(PATH_BIN_RLS) $(PATH_OBJS_RLS) $(LIBS_RLS)

$(DIR_OBJ_RLS)%.o: %.$(EXT)
	$(FC) $(RFLAGS) -J$(DIR_OBJ_RLS) -o $@ -c $<

.PHONY : debug
debug: prep_debug $(PATH_OBJS_DBG)
	$(FC) $(DFLAGS) -o $(PATH_BIN_DBG) $(PATH_OBJS_DBG) $(LIBS_DBG)

$(DIR_OBJ_DBG)%.o: %.$(EXT)
	$(FC) $(DFLAGS) -J$(DIR_OBJ_DBG) -o $@ -c $<

.PHONY : debugrun
debugrun: prep_debug debug
	$(DIR_PROJS)$(DIR_PROJ)$(NAME)/bin/Debug/$(NAME)

.PHONY : prep
prep: prep_release prep_debug

.PHONY : prep_release
prep_release:
	$(MKDIR) $(DIR_OBJ_RLS) $(DIR_BIN_RLS) $(DIR_LIB_RLS)

.PHONY : prep_debug
prep_debug:
	$(MKDIR) $(DIR_OBJ_DBG) $(DIR_BIN_DBG) $(DIR_LIB_DBG)

.PHONY : clean
clean: clean_release clean_debug

.PHONY : clean_release
clean_release:
	$(RM) $(PATH_BIN_RLS)
	$(RM) $(DIR_OBJ_RLS)*.*

.PHONY : clean_debug
clean_debug:
	$(RM) $(PATH_BIN_DBG)
	$(RM) $(DIR_OBJ_DBG)*.*

.PHONY : extra_clean
extra_clean:
	$(RM)r $(PATH_BIN_RLS) $(PATH_BIN_DBG) $(DIR_OBJ_RLS) $(DIR_OBJ_DBG) $(DIR_LIB_RLS) $(DIR_LIB_DBG)

.PHONY : install
install:
	$(MKDIR) $(DIR_BIN_INS)$(DIR_PROJ)
	$(CP) $(DIR_BIN_RLS)$(NAME) $(DIR_BIN_INS)$(DIR_PROJ)$(NAME)
	$(RM) /usr/bin/$(ID_PROG)_$(NAME)
	$(LN) $(DIR_BIN_INS)$(DIR_PROJ)$(NAME) /usr/bin/$(ID_PROG)_$(NAME)
	chown $(USR):$(USR) $(DIR_BIN_INS)$(DIR_PROJ)$(NAME)
	chown $(USR):$(USR) /usr/bin/$(ID_PROG)_$(NAME)

.PHONY : uninstall
uninstall:
	$(RM) $(DIR_BIN_INS)$(DIR_PROJ)$(NAME)
	find $(DIR_BIN_INS) -type d -empty -delete
	$(RM) /usr/bin/$(ID_PROG)_$(NAME)
