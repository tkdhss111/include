DIRS_INC_RLS +=$(DIR_TOOLS)grib2/ftn_api/
DIRS_INC_DBG +=$(DIRS_INC_RLS)

LIBS_RLS += $(DIR_TOOLS)grib2/ftn_api/libwgrib2_api.a $(wildcard $(DIR_TOOLS)grib2/lib/*.a)
LIBS_DBG += $(LIBS_RLS)
