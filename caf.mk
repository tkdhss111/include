FC := caf
CFLAGS += -Dcaf

# Overwrite
DIRS_INC_RLS = $(DIR_PROJS)utils_caf/lib/Release/
DIRS_INC_DBG = $(DIR_PROJS)utils_caf/lib/Debug/
LIBS_RLS = $(DIR_PROJS)utils_caf/lib/Release/libutils_caf.a
LIBS_DBG = $(DIR_PROJS)utils_caf/lib/Debug/libutils_caf.a
