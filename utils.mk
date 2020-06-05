DIRS_INC_RLS += $(DIR_PROJS)utils/lib/Release/
DIRS_INC_DBG += $(DIR_PROJS)utils/lib/Debug/
LIBS_RLS     += $(DIR_PROJS)utils/lib/Release/libutils.a -lfcgi
LIBS_DBG     += $(DIR_PROJS)utils/lib/Debug/libutils.a -lfcgi
LIBS_RLS     += $(DIR_PROJS)utils/aes256ctr/libaes256ctr.a
LIBS_DBG     += $(DIR_PROJS)utils/aes256ctr/libaes256ctr.a
