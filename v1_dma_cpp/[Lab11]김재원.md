## Lab 11

2014-17831 김재원

#### Follow tutorial & understand the DMA functionality
tcl 파일로 implementation을 한 결과입니다.
![block](block.png)

초기의 `main.c`를 실행한 결과입니다.
![main.c](initial.png)

아래는 product guide를 참고하여 작성한 내용입니다.
- page 4에 따르면, AXI CDMA는 AXI4 프로토콜에 따라 memory mapped Source Address (SA) 와 memory mapped Destination Address (DA) 간의 빠른 Direct Memory Access (DMA) 기능 - 즉, CPU를 거치지 않고 직접 접근을 하는 기능 - 을 제공한다. 
- page 13-14에 따르면, AXI CDMA register들은 4byte 간격으로 address space 상의 offset을 가진다. 이 때, `fpga_dma`가 포인터 변수이기 때문에 1을 증가할 때마다 4byte씩 증가가 되고, 그래서 SA의 값은 `fpga_dma+6`에, DA의 값은 `fpga_dma+8`에, Bytes to Transfer (BTT)의 값은 `fpga_dma+10`에 담기게 되는 것이다.
- page 27과 29에 따르면 SA와 DA register가 각각 32bit address를 담고 있음을 알 수 있다.
  - SA는 read/write type access가 모두 가능하고, read operation의 경우 0번째 offset에서부터 시작된다. Write operation은 다른 byte offset에서도 시작이 가능하다. 
    - 이 때, offset은 single data beat width 내의 byte position을 말한다. 즉, 32bit address의 경우 0, 1, 2, 3으로 총 네 개의 offset가 존재할 수 있을 것이다.
  - DA의 경우 read only로 access가 제한이 되어 있다. 단, SA와 마찬가지로 AXI CDMA가 idle이면 이 register에도 write가 가능하다.
    - Data Realignment Engine (DRE)이 포함되어 있지 않으면 SA와 DA가 일치해야 한다.
  - BTT는 26부터 31번째 bit까지, 총 6개의 reserved bits (RSVD)가 있다. 이 bit들은 항상 0으로 읽힌다.
    - 나머지 26개 bit는 Simple DMA transfer을 위해 사용되는데, SA부터 DA까지 DMA를 활용하여 옮기고 싶은 byte의 수를 말하고, 최대 67,108,863 byte의 데이터까지 옮길 수 있다. 
    - 이 register은 read와 write 모두 가능한데, 이 곳에 write를 하는 것은 simple DMA transfer이 시작된다는 신호로써 작용하기도 한다.
    - SA나 DA와 마찬가지로, AXI CDMA가 idle할 때 software application으로부터 write operation을 받을 수 있다.
    - 0의 값은 허용되지 않고, 0 값을 할당할 시 DMA 내부 오류가 발생한다. 
- `while ((*(fpga_dma+1) & 0x00000002) == 0);` 이라는 부분이 있는데, `fpga_dma+1`은 CDMA Status를 가리킨다. CDMA status의 두번째 bit은 Idle field이기 때문에 해당 bit가 0인 동안 지속을 하라는 의미는 Not Idle인 state, 즉, simple이나 SG DMA operation이 끝날 때까지 진행하라는 의미가 된다.
- `printf("check %d\n", *(fpga_dma) & 0x00000002);`를 추가해서 확인해본 결과, 0이 출력되었다. 즉, SG mode가 disabled된 simple DMA mode라는 것을 확인할 수 있었다. 

#### Compare data transfer using CDMA versus transferring data through CPU
다음과 같이 `main.c` 코드를 수정하였습니다. 
```C
  float *ps_dram = mmap(NULL, (SIZE * (SIZE + 1))* sizeof(float), PROT_READ|PROTT
_WRITE, MAP_SHARED, foo, 0x10000000);       // DRAM
  float *fpga_bram = mmap(NULL, (SIZE * (SIZE + 1))* sizeof(float), PROT_READ|PRR
OT_WRITE, MAP_SHARED, foo, 0x40000000);     // 수정

  // MCPY: DRAM -> BRAM
  gettimeofday (&st[0], NULL);
  /* flat의 데이터 SIZE * (SIZE + 1) * sizeof(float) 만큼을 fpga_bram으로 이동 */
  memcpy( fpga_bram, flat, SIZE * (SIZE + 1) * sizeof(float) );     // 수정
  gettimeofday (&st[1], NULL);

  // DMA : DRAM -> BRAM
  unsigned int *fpga_dma = mmap(NULL, 16*sizeof(unsigned int), PROT_READ|PROT_WRR
ITE, MAP_SHARED, foo, 0x7E200000);      // DMA module

  gettimeofday (&st[2], NULL);
  *(fpga_dma+6) = 0x10000000;   // SA: DRAM 주소
  *(fpga_dma+8) = 0xC0000000;   // DA: BRAM 주소 (CDMA 관점)
  *(fpga_dma+10) = SIZE * (SIZE + 1) * sizeof(float);   // BTT (이동해야 할 데이터 양)
  while ((*(fpga_dma+1) & 0x00000002) == 0);    // operation이 끝날 때까지
  gettimeofday (&st[3], NULL);

  // Check if the data is valid
  int num_mismatch = 0;
  for (i = 0; i < SIZE * (SIZE + 1); i++)
  {
    if ( *(fpga_bram + i) != *(ps_dram + i) )       // BRAM과 DRAM 데이터 비교 (DRAM -> BRAM으로 이동하였음)
    {
      printf("%f, %f\n", *(fpga_bram + i), *(ps_dram + i) );
      num_mismatch++;
    }
  }

  printf("The number of mismatch (dram <-> bram) : %d\n", num_mismatch);

  printf("%s: %d\n", "MCPY", st2time(st[ 1]) - st2time(st[ 0]));    // memcpy 함수로 CPU 통해 전송 시 소요시간 (in us)
  printf("%s: %d\n", "DMA ", st2time(st[ 3]) - st2time(st[ 2]));    // DMA로 전송 시 소요시간 (in us)

  close(foo);
```
- DRAM -> BRAM의 이동에 관한 memcpy 코드에 `ps_dram` 대신 BRAM에 map된 `fpga_bram`를 넘겨주어 DRAM에서 BRAM으로의 memcpy가 일어나도록 수정했습니다.
- data transfer의 validity check를 위해 코드 아랫단에 선언되어있던 `fpga_bram`은 위 수정사항을 동작시키기 위해 앞부분으로 옮겨두었습니다.
- 위 코드의 주석을 통해 `main.c`의 동작에 대해 이해한 바를 적어두었습니다.

실행결과는 다음과 같습니다.
![edit]([Lab11]김재원_screenshot.png)

- 결국, DRAM에서 BRAM로 데이터를 옮길 시, DMA를 활용하는 것이 CPU를 거쳐 코드를 작성하는 것에 비해 훨씬 빠르게 동작함을 알 수 있었습니다.
- 게다 기존 코드에서 같은 양의 데이터를 옮기기 위해 DRAM에서 DRAM으로 옮기는 것은 175us 가량, BRAM으로 옮기는 과정은 360us 가량이 소요되어 BRAM으로 이동 시 더욱 많은 시간이 들게 됩니다.
- for loop보다 훨씬 빠른 `memcpy` 함수를 사용하였음에도 불구하고, 16640 bytes를 옮기는 데에 있어 CPU를 통한 데이터 이동은 약 5배 정도 더 많은 시간이 소요되었습니다.