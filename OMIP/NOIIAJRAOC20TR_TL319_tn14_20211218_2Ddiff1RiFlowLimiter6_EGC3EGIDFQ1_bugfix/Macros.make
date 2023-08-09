SUPPORTS_CXX := FALSE
ifeq ($(COMPILER),intel)
  SUPPORTS_CXX := TRUE
  CFLAGS :=   -qno-opt-dynamic-align -fp-model precise -std=gnu99 
  CXX_LDFLAGS :=  -cxxlib 
  CXX_LINKER := FORTRAN
  FC_AUTO_R8 :=  -r8 
  FFLAGS :=  -qno-opt-dynamic-align  -convert big_endian -assume byterecl -ftz -traceback -assume realloc_lhs -fp-model source  
  FFLAGS_NOOPT :=  -O0 
  FIXEDFLAGS :=  -fixed -132 
  FREEFLAGS :=  -free 
  MPICC :=  mpicc 
  MPICXX :=  mpicpc 
  MPIFC :=  mpifort 
  SCC :=  icc 
  SCXX :=  icpc 
  SFC :=  ifort 
  NETCDF_PATH := $(EBROOTNETCDFMINFORTRAN)
  PNETCDF_PATH := $(EBROOTPNETCDF)
  MPI_PATH := $(MPI_ROOT)
  MPI_LIB_NAME := mpi
  PIO_FILESYSTEM_HINTS := lustre
endif
ifeq ($(MODEL),pop)
  CPPDEFS := $(CPPDEFS)  -D_USE_FLOW_CONTROL 
endif
ifeq ($(COMPILER),intel)
  FFLAGS := $(FFLAGS)  -xavx2 -no-fma 
  CPPDEFS := $(CPPDEFS)  -DFORTRANUNDERSCORE -DCPRINTEL
  CPPDEFS := $(CPPDEFS)  -D$(OS) 
  SLIBS := $(SLIBS) -mkl=sequential -lnetcdff -lnetcdf
  ifeq ($(compile_threaded),true)
    FFLAGS := $(FFLAGS)  -qopenmp 
  endif
  ifeq ($(MODEL),cice)
    FFLAGS := $(FFLAGS)  -init=zero,arrays 
    FFLAGS := $(FFLAGS)  -init=zero,arrays 
  endif
  ifeq ($(MODEL),blom)
    FFLAGS := $(FFLAGS)  -r8 
  endif
  ifeq ($(compile_threaded),true)
    CFLAGS := $(CFLAGS)  -qopenmp 
  endif
  ifeq ($(DEBUG),FALSE)
    CFLAGS := $(CFLAGS)  -O2 -debug minimal 
    FFLAGS := $(FFLAGS)  -O2 -debug minimal 
    FFLAGS := $(FFLAGS)  -O2 
  endif
  ifeq ($(DEBUG),TRUE)
    CFLAGS := $(CFLAGS)  -O0 -g 
    FFLAGS := $(FFLAGS)  -O0 -g -check uninit -check bounds -check pointers -fpe0 -check noarg_temp_created 
  endif
  ifeq ($(MPILIB),mpich)
    SLIBS := $(SLIBS)  -mkl=cluster 
  endif
  ifeq ($(MPILIB),mpich2)
    SLIBS := $(SLIBS)  -mkl=cluster 
  endif
  ifeq ($(MPILIB),mvapich)
    SLIBS := $(SLIBS)  -mkl=cluster 
  endif
  ifeq ($(MPILIB),mvapich2)
    SLIBS := $(SLIBS)  -mkl=cluster 
  endif
  ifeq ($(MPILIB),mpt)
    SLIBS := $(SLIBS)  -mkl=cluster 
  endif
  ifeq ($(MPILIB),openmpi)
    SLIBS := $(SLIBS)  -mkl=cluster 
  endif
  ifeq ($(MPILIB),impi)
    SLIBS := $(SLIBS)  -mkl=cluster 
  endif
  ifeq ($(MPILIB),mpi-serial)
    SLIBS := $(SLIBS)  -mkl 
  endif
  ifeq ($(compile_threaded),true)
    FFLAGS_NOOPT := $(FFLAGS_NOOPT)  -qopenmp 
    LDFLAGS := $(LDFLAGS)  -qopenmp 
  endif
endif
