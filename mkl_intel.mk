#============================================================================
# Intel Math Kernel Library for ifort (Parallel Studio XE2020)
#----------------------------------------------------------------------------
#
#
# For the library links, check the following website.
#
# Intel® Math Kernel Library Link Line Advisor 
# URL: https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor
#
# Created by: Hisashi Takeda, Ph.D. on: March 15, 2020.
#----------------------------------------------------------------------------

MKLROOT :=/opt/intel/mkl

DIRS_INC_RLS +=${MKLROOT}/include/intel64/lp64 ${MKLROOT}/include
DIRS_INC_DBG +=${MKLROOT}/include/intel64/lp64 ${MKLROOT}/include

LIBS_RLS +=${MKLROOT}/lib/intel64/libmkl_blas95_lp64.a
LIBS_RLS +=${MKLROOT}/lib/intel64/libmkl_lapack95_lp64.a -Wl,--start-group 
LIBS_RLS +=${MKLROOT}/lib/intel64/libmkl_intel_lp64.a
LIBS_RLS +=${MKLROOT}/lib/intel64/libmkl_intel_thread.a
LIBS_RLS +=${MKLROOT}/lib/intel64/libmkl_core.a -Wl,--end-group -liomp5 -lpthread -lm -ldl

LIBS_DBG +=${MKLROOT}/lib/intel64/libmkl_blas95_lp64.a
LIBS_DBG +=${MKLROOT}/lib/intel64/libmkl_lapack95_lp64.a -Wl,--start-group 
LIBS_DBG +=${MKLROOT}/lib/intel64/libmkl_intel_lp64.a
LIBS_DBG +=${MKLROOT}/lib/intel64/libmkl_intel_thread.a
LIBS_DBG +=${MKLROOT}/lib/intel64/libmkl_core.a -Wl,--end-group -liomp5 -lpthread -lm -ldl

