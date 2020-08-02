#cmake_minimum_required ( VERSION 3.0 )
#project ( hello LANGUAGES Fortran VERSION 1.0.0 )

enable_language ( Fortran )
enable_testing ()

if ( CMAKE_Fortran_COMPILER_ID MATCHES "GNU" )
  set ( dialect "-cpp -ffree-line-length-none -fopenmp -fdec-math -mcmodel=large -pthread -Dlinux -fcoarray=lib" )
  set ( bounds "-fbounds-check -Ddebug" )
endif ()

if ( CMAKE_Fortran_COMPILER_ID MATCHES "Intel" )
  set ( dialect "-fpp -free -Dlinux -Dintel -parallel -mcmodel=large" )
  set ( bounds "-check bounds -Ddebug" )
endif ()

if ( CMAKE_Fortran_COMPILER_ID MATCHES "PGI" )
  set ( dialect "-Mfreeform -Mdclchk -Mstandard -Mallocatable=03" )
  set ( bounds "-C" )
endif ()

set ( CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} ${bounds}" )
set ( CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${dialect}" )
