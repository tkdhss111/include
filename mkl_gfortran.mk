#============================================================================
# Intel Math Kernel Library for gfortran (free version)
#----------------------------------------------------------------------------
#
# (Preparetion)
# Manually run installation script for blas95 and lapack95 interface library.
#
# For the library links, check the following website.
#
# Intel® Math Kernel Library Link Line Advisor 
# URL: https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor
#
# Created by: Hisashi Takeda, Ph.D. on: April 02, 2020.
#---------------------------------------------------------------------------

MKLROOT := /opt/intel/mkl
F95ROOT := $(DIR_TOOLS)mkl

LIBS_RLS +=${F95ROOT}/lib/intel64/libmkl_blas95_lp64.a 
LIBS_RLS +=${F95ROOT}/lib/intel64/libmkl_lapack95_lp64.a -Wl,--start-group 
LIBS_RLS +=${MKLROOT}/lib/intel64/libmkl_gf_lp64.a 
LIBS_RLS +=${MKLROOT}/lib/intel64/libmkl_gnu_thread.a 
LIBS_RLS +=${MKLROOT}/lib/intel64/libmkl_core.a -Wl,--end-group -lgomp -lpthread -lm -ldl

LIBS_DBG +=${F95ROOT}/lib/intel64/libmkl_blas95_lp64.a 
LIBS_DBG +=${F95ROOT}/lib/intel64/libmkl_lapack95_lp64.a -Wl,--start-group 
LIBS_DBG +=${MKLROOT}/lib/intel64/libmkl_gf_lp64.a 
LIBS_DBG +=${MKLROOT}/lib/intel64/libmkl_gnu_thread.a 
LIBS_DBG +=${MKLROOT}/lib/intel64/libmkl_core.a -Wl,--end-group -lgomp -lpthread -lm -ldl

DIRS_INC_RLS +=$(F95ROOT)/include/intel64/lp64 $(MKLROOT)/include
DIRS_INC_DBG +=$(F95ROOT)/include/intel64/lp64 $(MKLROOT)/include

# NB. Do not use the following options! It is sometimes slow.
#CFLAGS += -fexternal-blas
