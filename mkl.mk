DIR_MKL      := /opt/intel/mkl/
DIRS_INC_RLS += $(addprefix $(DIR_MKL), include/intel64/lp64 include)
LIBS_RLS     += $(addprefix ${DIR_MKL}/lib/intel64/, libmkl_blas95_lp64.a libmkl_lapack95_lp64.a libmkl_gf_lp64.a libmkl_gnu_thread.a libmkl_core.a)
LIBS_RLS     += -Wl,--start-group -Wl,--end-group -lgomp -lpthread -lm -ldl 
#CFLAGS        += -fexternal-blas
