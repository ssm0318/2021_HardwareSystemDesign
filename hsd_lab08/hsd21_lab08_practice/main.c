#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/mman.h>

#define SIZE 4

int main(int argc, char** argv)
{
  int i;

  /*
   * open(): opens a file
   * O_NONBLOCK is clear: 
   *    - read: 다른 thread가 write로 파일에 쓸 때까지 기다림.
   *    - write: 다른 thread가 read()로 들어갈 때까지 기다림.
   * O_RDWR: open file for read/write
   * return value: file descriptor
   */
  int foo = open("/dev/mem", O_RDWR);
  /* 
   * mmap() creates a new mapping in the virtual address space of the calling process.
   * mmap(void *addr - starting_address, 
          size_t length - length of the mapping,
          int prot - describes the desired memory protection of the mapping (PROT_READ/WRITE: pages may be read/written.),
          int flags - determines whether updates to the mapping are visible to other processes mapping the same region,
                      and whether updates are carried through the underlying file (MAP_SHARED: share this mapping.),
          int fd - file containing the contents of a file mapping (if not an anonymous mapping)
          off_t offset - offset in memory);
   *  - if addr is NULL, the kernel chooses the (page-aligned) address at which to create the mapping
   *  - If addr is  not NULL,  then the kernel takes it as a hint about where to place the mapping
   *    - on Linux, the kernel will pick a nearby page boundary and attempt to create the mapping there.
   *    - If another mapping already exists there, the kernel picks a new address that may or may not depend on the hint.
   *    - The address of the new mapping is returned as the result of the call.
   * BRAM is @ address 0x4000_0000 ~ 0x4000_1FFF
   */
  int *fpga_bram = mmap(NULL, SIZE * sizeof(int), PROT_READ|PROT_WRITE, MAP_SHARED, foo, 0x40000000);
  int *fpga_ip   = mmap(NULL, sizeof(int), PROT_READ|PROT_WRITE, MAP_SHARED, foo, 0x43C00000);

  /*
   * Initialize Memory
   * for i = 0 ~ 3, store value (i * 2) @addr i in BRAM
   * for i = 4 ~ 7, store value (0.0f) @addr i in BRAM
   */
  for (i = 0; i < SIZE; i++)
    *(fpga_bram + i) = (i * 2);
  for (i = SIZE; i < SIZE * 2; i++)
    *(fpga_bram + i) = 0.0f;

  printf("%-10s%-10s\n", "addr", "FPGA(hex)");
  /*
   * Print Memory
   * for i = 0 ~ 7, print data stored @addr i in BRAM 
   */
  for (i = 0; i < SIZE * 2; i++)
    printf("%-10d%-10X\n", i, *(fpga_bram + i));

  printf("%-10s%-10s\n", "addr", "IP(hex)");
  /*
   * Print Data Stored @IP
   */
  for (i = 0; i < SIZE; i++)
    printf("%-10d%-10X\n", i, *(fpga_ip + i));

  /*
   * Run IP
   * set value @fpga_ip[0] as 0x5555
   * run while the value @fpga_ip[0] remains as 0x5555
   */
  *(fpga_ip) = 0x5555;
  while (*fpga_ip == 0x5555);

  printf("%-10s%-10s\n", "addr", "FPGA(hex)");
  /*
   * Print Memory
   * for i = 0 ~ 7, print data stored @addr i in BRAM 
   */
  for (i = 0; i < SIZE * 2; i++)
    printf("%-10d%-10X\n", i, *(fpga_bram + i));

  return 0;
}

