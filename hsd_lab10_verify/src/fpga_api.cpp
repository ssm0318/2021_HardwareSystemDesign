#include "fpga_api.h"
#include <cstdio>
#include <cstring>

#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

#define DATA_SIZE SIZE*(SIZE+1)*sizeof(float) // fpga bram data size

#define min(x,y) (((x)<(y))?(x):(y))

FPGA::FPGA(off_t data_addr, off_t api_addr)
{
    fd_ = open("/dev/mem", O_RDWR);
    data_ = static_cast<float*>(mmap(NULL, DATA_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd_, data_addr));
    api_ = static_cast<unsigned int*>(mmap(NULL, sizeof(unsigned int), PROT_READ|PROT_WRITE, MAP_SHARED,fd_, api_addr));
    fpga_dma = static_cast<unsigned int*>(mmap(NULL, 16*sizeof(unsigned int), PROT_READ|PROT_WRITE, MAP_SHARED, fd_, 0x7E200000));
}

FPGA::~FPGA()
{
    munmap(data_, DATA_SIZE );
    munmap(api_, sizeof(unsigned int));
    close(fd_);
}

float* FPGA::matrix_M1(void)
{
	return data_ ;
}

float* FPGA::matrix_M2(void)
{
	return data_ + SIZE * SIZE;
}

const float* __attribute__((optimize("O0"))) FPGA::run()
{
    *api_ = 0x5555;
    while(*api_ == 0x5555);

    return data_;    
}

// Test code for bitstream
void FPGA::largeMM(const float* weight_mat, const float* input_mat, float* output, 
							int num_input, int num_output, int num_matrix2)
{
	float* m1 = this->matrix_M1();
	float* m2 = this->matrix_M2();
	for(int i = 0; i < num_output*num_matrix2; ++i)
    output[i] = 0;

  for(int i = 0; i < num_output; i += SIZE)
  {
    for(int j = 0; j < num_input; j += SIZE)
    {			
      for(int k = 0; k < num_matrix2; k += SIZE)
      {
        // 0) Initialize input vector
        int block_row = min(SIZE, num_output-i);
        int block_col_1 = min(SIZE, num_input-j);
        int block_col_2 = min(SIZE, num_matrix2-k);

        // // 1) Assign a m1
        // for(int row = 0; row < SIZE; ++row)
        // {
        //   memset(m1 + (SIZE*row), 0, sizeof(float) * SIZE);
        //   if(row < block_row)
        //   {
        //     memcpy(m1 + (SIZE*row), weight_mat + (num_input*(i+row)) + j, sizeof(float) * block_col_1);
        //   }
        // }

        // // 2) Assign a m2
        // for(int row = 0; row < SIZE; ++row)
        // {
        //   memset(m2 + (SIZE*row), 0, sizeof(float) * SIZE);
        //   if(row < block_col_1)
        //   {
        //     memcpy(m2 + (SIZE*row), input_mat + (num_matrix2*(j+row)) + k, sizeof(float) * block_col_2);
        //   }
        // }
        // 1) Assign a m1
        *(fpga_dma+6) = (unsigned int) weight_mat;
        *(fpga_dma+8) = 0xC0000000;
        *(fpga_dma+10) = sizeof(float) * block_col_1 * block_row;
        while ((*(fpga_dma+1) & 0x00000002) == 0);

        // 2) Assign a m2
        *(fpga_dma+6) = (unsigned int) input_mat;
        *(fpga_dma+8) = 0xC0000000 + SIZE * SIZE;
        *(fpga_dma+10) = sizeof(float) * block_col_2 * block_col_1;
        while ((*(fpga_dma+1) & 0x00000002) == 0);

        // printf("m1\n");
        // for(int n = 0; n<SIZE; ++n)
        // {
        //   for(int m = 0; m<SIZE; ++m)
        //   {
        //     printf("%10f ", m1[n*SIZE+m]);
        //   }
        //   printf("\n");
        // }

        // printf("m2\n");
        // for(int n = 0; n<SIZE; ++n)
        // {
        //   for(int m = 0; m<SIZE; ++m)
        //   {
        //     printf("%10f ", m2[n*SIZE+m]);
        //   }
        //   printf("\n");
        // }

        printf("%p %p\n", (unsigned int) weight_mat, (unsigned int) input_mat);

        // 3) Call a function `blockMM() to execute Matrix matrix multiplication
        const float* rst = this->run();

        // 4) Accumulate intermediate results
        // It is slightly different from the code for the project.
        // for(int n = 0; n<block_row; ++n)
        // {
        //   for(int m = 0; m<block_col_2; ++m)
        //   {
        //     output[n*SIZE + m] += rst[n*SIZE + m];
        //   }
        // }
		// 4) Accumulate intermediate results
        *(fpga_dma+6) = 0xC0000000;
        *(fpga_dma+8) = (unsigned int) output;
        *(fpga_dma+10) = sizeof(float) * block_row * block_col_2;
        while ((*(fpga_dma+1) & 0x00000002) == 0);
      } 
	  }
  }
}
