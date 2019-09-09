MKLROOT := /opt/intel/mkl
F95ROOT := /home/jma/2_Tools/mkl

LIBS_RLS +=$(F95ROOT)/lib/intel64/libmkl_blas95_lp64.a $(F95ROOT)/lib/intel64/libmkl_lapack95_lp64.a -Wl,--start-group $(MKLROOT)/lib/intel64/libmkl_gf_lp64.a $(MKLROOT)/lib/intel64/libmkl_intel_thread.a $(MKLROOT)/lib/intel64/libmkl_core.a -Wl,--end-group -lgomp5 -lpthread -lm -ldl

DIRS_INC_RLS +=$(F95ROOT)/include/intel64/lp64 $(MKLROOT)/include

#CFLAGS += -fexternal-blas
