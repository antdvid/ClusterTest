CC = mpicc
CCFLAGS = 

NC = /opt/cuda/bin/nvcc
NC_LIB = -L /opt/cuda/lib -lcudart

SRC_DIR = ./src

PETSC_DIR = /opt/petsc3.6-mpich2
PETSC_INCL_DIR = $(PETSC_DIR)/include
PETSC_LIB_DIR = $(PETSC_DIR)/lib

all: mpi_hw.cx mpi_poisson.cx cuda_hw.gx omp_stream.cx mpi_stream.cx mpi_petsc.cx
clean:
	rm -f *.cx *.gx *.o* *.po*
clean_out:
	rm -f *.o* *.po* *.e*

#compiling rules for specific problem
mpi_stream.cx: $(SRC_DIR)/mpi_stream.c
	mpicc -O3 -std=c99 -ffreestanding -mcmodel=medium \
            -DSTREAM_ARRAY_SIZE=400000000 -DNTIMES=20 \
            $(SRC_DIR)/mpi_stream.c -o mpi_stream.cx

omp_stream.cx: $(SRC_DIR)/omp_stream.c
	mpicc -O3 -fopenmp $(SRC_DIR)/omp_stream.c -o omp_stream.cx

mpi_petsc.cx: $(SRC_DIR)/mpi_petsc.c
	mpicc -O3 -c $(SRC_DIR)/mpi_petsc.c -I$(PETSC_INCL_DIR)
	mpicc -O3 mpi_petsc.o -L$(PETSC_LIB_DIR) -lpetsc -o mpi_petsc.cx
	rm mpi_petsc.o

#generic compiling, should not be modified
%.cx: $(SRC_DIR)/%.c 
	$(CC) $(CCFLAG) $< -o $@

%.gx: $(SRC_DIR)/%.cu
	$(NC) $< $(NCLIB) -o $@

