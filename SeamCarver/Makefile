CC=g++
NVCC=nvcc
CXXFLAGS= -g -std=c++11 -fpermissive
CUDAFLAGS= -std=c++11 -arch=sm_50
LIBS= -lopenblas -lpthread -lcudart -lcublas
LIBDIRS=-L/usr/local/cuda-7.5/lib64
INCDIRS=-I/usr/local/cuda-7.5/include
seam-carver:	seam-carver.cu
	$(NVCC)	$(CUDAFLAGS)	seam-carver.cu -o seam-carver