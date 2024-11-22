- 이번 학기 마지막 실습인 dma.
- 그동안 수고했고 마지막까지 열심히해서 프로젝트 잘 마무리하시길.
- 이번 실습의 overview. 우선 performance를 분석하는 법, 그리고 memcpy 함수와 dma를 통해 퍼포먼스를 더 높이는 방법에 대해 알아보도록 하겠습니다.
- 이번 실습의 report due는 6월 2일 수요일.
- 비교적 간단한 실험이지만 저희 프로젝트 중간제출과 기한 겹치니 빠르게 실습 마치고 제출하는 것을 추천드립니다.
- 수행하고자 하는 application을 구현했으면 그 퍼포먼스를 최대로 올리는 것이 중요.
- 그러기 위해서는 퍼포먼스가 어느정도이고, 어느 시점에서 bottleneck이 생기는지 파악해야 성능을 어떻게 올릴지 결정할 수 있음.
- 리눅스에서는 performance 측정을 위해 여러 tool을 제공 중이며 우리는 이번 실습에서 gettimeofday 함수를 이용할 것.
- 우선 memcpy 함수로 성능 향상 가능. 
- for문을 통해 값을 할당하는 것보다 memcpy 함수가 훨씬 빠른데 memcpy 함수가 하드웨어적으로 더 최적화되어있기 때문이기도 하고 for문에는 종류를 체크하는 등 추가적 overhead가 존재하기 때문이기도 함.
- 그리고 이번 실습에서는 dma를 사용해보도록 하겠음.
- 여기서 배운 dma를 term project에 적용함으로써 퍼포먼스를 더 향상 가능.
- etl에 두개 파일 업로드했는데 첫번째는 block design tcl파일
- 이전 실습에서 했던 방식대로 vivado에 tcl 콘솔을 이용해서 block dma s??? 파일을 실행시키고 그림과 같은 block design을 얻습니다.
- 그리고 hdl wrapper 만들고 bitstream 생성.
- block design address 값은 아래와 같음. 그림에서 확인할 수 있는 점은 ps에서 보는 bram의 주소값과 dma에서 보는 주소값입니다. 
- 같은 bram을 다른 주소값을 통해 보고 있다는 점을 생각해주시면 됩니다. 
- 그래서 main code 파일을 보시면 아시겠지만 ps에서 bram에 접근할때와 cdma에서 operation을 할 때 사용하는 주소값이 다름.
- dma를 사용하기 위해서는 우선 data를 non cacheable한 dram의 영역으로 옮겨서 dram으로 옮기게 됨. 
- 이 작업을 위해 board의 일정 ?? space를 non cacheable로 사용해야 되는데 그 정보를 담은 uboot image file을 etl에 같이 업로드했음.
- sd card에 uboot.image 파일을 첨부된 uboot.image.nc 파일로 대체해주면 되는데 sd card에 넣으면서 u-boot.image 이름으로 바꿔줘야됨.
- 그렇게 부팅한 뒤 코드 받아서 make하게 되면 코드를 실행시킬 수 있고 main 코드를 보면 memcpy와 dma operation을 확인할 수 있음. 
- 이번주 실습은 위 튜토리얼 따라한 후 dma function을 이해하는 것.
- cdma product guideline을 읽어보시고 main code가 어떻게 동작하는지 분석하셔야 됨.
- term project optimization version에서 dma를 구현하게 된다면 ps, bram, connectivity, custom ip에다가 cdma까지 포함하여 구현하면 됨.
- 실습의 main code와 같이 cdma를 이용하기 위해 software code파일도 고치셔야 함.
- 그리고 이번 실습에서 코드를 직접 수정해보며 cdma에서 bram의 데이터를 쓰는 작업과 cpu를 통해 bram에 데이터를 쓰는 작업을 모두 실행시켜보시고 비교해주시면 됨.
- 결과 파일은 main.c를 동작시킨 결과와 함께 이름/학번 스크린샷해서.
- 리포트는 앞의 페이지에서 언급한 부분들을 모두 분석해서 적어주면 됨.
- 6월 2일까지 제출이고 딜레이는 없음.

- 하시설 질문 답
  - lab 11에서는 dram에서 bram으로 데이터 옮김. lab 11에서는 cpu에서 bram으로 직접적인 접근 가능. mmap으로 지정해서 접근한 것.
  - 어떻게 연결돼서 cpu하고 bram이 직접적으로 소통할 수 있게 설계되었는지
  - cpu로 dma register에 명령을 적어서 dram과 bram 간에 소통도 가능한데 이건 어떻게 가능한지?
  - lab 11를 보고 어느 모듈을 넣고 어느 모듈을 빼면 될지.
  - bram port는 두 개 뿐인데 myip랑 dma랑 cpu랑 다 연결이 되어야해서
  - 힌트: lab 11 block design에서 수정하는게 빠름. C코드도 수정. (8x8짜리 두 개 옮기는 과정을 dram에서 bram으로 직접 일어날 수 있도록 수정.)

해당 에러는 원인이 다양하기도 하며 형평성의 문제로 직접 디버깅을 해드릴 순 없어서 정확한 에러의 이유를 말씀드릴 순 없을 것 같습니다.
간단히 보았을땐 학생분의 SW code 자체에 문제가 있어 보입니다. non-cachable dram 사용여부, tiling 여부, CDMA가 바라보는 주소값을 적었는지에 대한 여부 등등...
또한 lab11 의 경우는 bram 에 PS 가 직접 access 가 가능한 구조이지만 학생분의 block design 은 그렇지 않습니다. 그런 점들을 고려하셔서 디버깅을 해주시면 될 것 같습니다.

CDMA 가 보는 BRAM 의 주소값은 Vivado 에서 특별히 수정을 하시지 않으셨다면 0xC0000000 이 맞을겁니다. 하지만 CDMA 가 바라보는 DRAM 의 주소값도 생각을 해주셔야합니다. 포인터의 형식으로 CDMA source or destination address 에 적어주셨는데 그 포인터가 가르키는 주소값이 CDMA 가 바라보는 DRAM 의 주소값인지 확인 해보시면 좋을 것 같습니다.
