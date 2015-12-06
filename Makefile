CC = mpicc
CCFLAGS = 

NC = nvcc
NC_LIB = -L /usr/local/cuda/lib -lcudart

SRC_DIR = ./src

all: mpi_hw.cx mpi_poisson.cx cuda_hw.gx
clean:
	rm *.cx *.gx

#generic compiling, should not be modified
%.cx: $(SRC_DIR)/%.c 
	$(CC) $(CCFLAG) $< -o $@

%.gx: $(SRC_DIR)/%.cu
	$(NC) $< $(NCLIB) -o $@

