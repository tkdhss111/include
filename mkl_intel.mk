DIR_MKL     :=/opt/intel/mkl/
DIR_LIB_MKL :=${DIR_MKL}lib/intel64_lin/
DIR_INC_MKL :=${DIR_MKL}include/

DIR_LIB_RLS +=${DIR_LIB_MKL}
DIR_LIB_DBG +=${DIR_LIB_MKL}

DIRS_INC_RLS +=${DIR_INC_MKL} ${DIR_INC_MKL}intel64/lp64
DIRS_INC_DBG +=${DIR_INC_MKL} ${DIR_INC_MKL}intel64/lp64

CFLAGS +=-lmkl_lapack95_lp64
CFLAGS +=-lmkl_blas95_lp64
CFLAGS +=-Wl,--start-group ${DIR_LIB_MKL}libmkl_intel_lp64.a
CFLAGS +=${DIR_LIB_MKL}libmkl_intel_thread.a
CFLAGS +=${DIR_LIB_MKL}libmkl_core.a -Wl,--end-group -liomp5 -lpthread -lm

