---
title: "시스템프로그래밍 FTW 구현"
date: 2018-08-10T10:25:23+06:00
description: 알고리즘 문제풀이시 참고 할 수 있는 Tip 모음입니다.
menu:
  sidebar:
    name: 시스템프로그래밍 FTW 구현
    identifier: embedded-System
    parent: sub-computer-science
    weight: 10
tags:
- Study
- Embeded-System
- C
---


## Embedded System?

> An embedded system is a computer system --- 작은 컴퓨터 라고 생각하자.
>
> Dedicated function --- 시스템에 맞춰 특정 동작을 한다.
>
> Within a lager mechanical or electronical system  
>
> 더 큰 시스템의 일부로 내장(embedded)된다.
>
> 큰 시스템 안에 여러개의 임베디드 시스템이 동시에 존재할 수 있다.

- Characteristic of Embedded system
  - 특정 기능을 수행
  - 하드웨어 + 소프트웨어로 구성
  - 하드웨어 변경 쉽지 않음
  - 제한적인 자원
  - 고 신뢰성, 실시간성의 요구



## SoC

> SoC(System on chip) 은

![soc 참고](https://upload.wikimedia.org/wikipedia/commons/8/85/ARMSoCBlockDiagram.svg)


## volatile 쓰는 이유

> 실시간으로 변하는 값을 가져와야 할때, 컴파일러는 같은주소에서 값을 가져 오려고 하면안함.때문에 최적화를 시키면 안됨!

```c
READ A
PRINT A
READ A
PRINT A
...
compiile optimize
...>

READ A
PRINT A
PRINT A
//READ A를 지워버리는 이유를 같은 주소에서 값을 가져오기떄문에 지우는것!(같은 일을 하지 않기 위해서)
// 근데 실상 A가 실시간으로 변하는 값이라서 매번 가져와야 하는데 저렇게 안가져오면 같은 값이 나오게된다.
// 그래서 volatile이 쓰인다.

// Using volatile
volatile A
READ A
PRINT A
READ A
PRINT A
...
compiile optimize
...>
READ A
PRINT A
READ A
PRINT A
```



### gcc-arm tool chain 설치방법

mac용 다운로드 [GNU Arm Embedded Toolchain](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads)
```shell
$ mkdir /usr/local/gcc-arm
$ tar -xjf gcc-arm-none-eabi-7-2018-q2-update-mac.tar.tar.bz2 -C /usr/local/gcc-arm
# /usr/local/gcc-arm 안에 설치되어 있다.
$ sudo chmode -R -w /usr/local/gcc-arm
# 설치 확인
$ arm-none-eabi-gcc --version
arm-none-eabi-gcc (GNU Tools for Arm Embedded Processors 7-2018-q2-update) 7.3.1 20180622 (release) [ARM/embedded-7-branch revision 261907]
Copyright (C) 2017 Free Software Foundation, Inc.
```

### homebrew 설치 방법(되는건지 잘 모르겠음)
```shell
$ brew tap PX4/homebrew-px4
$ brew update
$ brew install gcc-arm-none-eabi
```

### 맥용 objdump 설치 방법
> objdump는 deassemble을 해서 분석하기 위해 사용된다.
> Mac 에서는 otool 이라는것이 존재하는데 어떻게 사용하는지 잘모르겠고,
> objdump보다 더 불친절 하게 출력해준다. 

```shell
$ brew install binutils
$ gobjdump
# /usr/local/Cellar/binutils/2.30 에 가보면 objdump가 아니라
# gobjdump로 되어있다 아마 맥에서 prefix가 바뀌어서 그런듯
$ vi ~/.bashrc
# In .bashrc  다음 내용 추가
export PATH="/usr/local/gcc-arm/gcc-arm-none-eabi-7-2018-q2-update/arm-none-eabi/bin:/usr/local/gcc-arm/gcc-arm-none-eabi-7-2018-q2-update/bin:$PATH"


$ arm-none-eabi-gcc --version
arm-none-eabi-gcc (GNU Tools for Arm Embedded Processors 7-2018-q2-update) 7.3.1 20180622 (release) [ARM/embedded-7-branch revision 261907]
Copyright (C) 2017 Free Software Foundation, Inc.

```

## ex 예제
ex 폴더에서 make하면 image가 만들어짐
```shell
$ cd /ex
$ vi Makefile
VERSION     = 7.3.1
//7.3.1 버전이라 저렇게 수정해야댐
TOOLPATH    = /usr/local/gcc-arm/gcc-arm-none-eabi-7-2018-q2-update
//이렇게 수정함.
//arm-none-eabi-gcc (GNU Tools for Arm Embedded Processors 7-2018-q2-update) //7.3.1 20180622 (release) [ARM/embedded-7-branch revision 261907]
//Copyright (C) 2017 Free Software Foundation, Inc.
$ vi startup.S
#msr        FPEXC,r0  # 여기 부분 주석 처리해야댐 자구 오류남
$ make
$ ls
...
image image.bin image.map 세가지가 생김
...

$ greadelf -S image
There are 16 section headers, starting at offset 0x94e0:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .text             PROGBITS        20000000 000058 001f8c 00  AX  0   0  4
  [ 2] .rodata           PROGBITS        20001f8c 001fe4 000014 00   A  0   0  4
  [ 3] .data             PROGBITS        20001fa0 001ff8 000020 00  WA  0   0  8
  [ 4] .bss              NOBITS          20001fc0 002018 0017b8 00  WA  0   0  8
  [ 5] .debug_info       PROGBITS        00000000 002018 0019c2 00      0   0  1
  [ 6] .debug_abbrev     PROGBITS        00000000 0039da 000457 00      0   0  1
  [ 7] .debug_aranges    PROGBITS        00000000 003e38 000080 00      0   0  8
  [ 8] .debug_line       PROGBITS        00000000 003eb8 000955 00      0   0  1
  [ 9] .debug_str        PROGBITS        00000000 00480d 00094c 01  MS  0   0  1
  [10] .comment          PROGBITS        00000000 005159 00007f 01  MS  0   0  1
  [11] .ARM.attributes   ARM_ATTRIBUTES  00000000 0051d8 000039 00      0   0  1
  [12] .debug_frame      PROGBITS        00000000 005214 0004c4 00      0   0  4
  [13] .symtab           SYMTAB          00000000 0056d8 0027f0 10     14 468  4
  [14] .strtab           STRTAB          00000000 007ec8 00157e 00      0   0  1
  [15] .shstrtab         STRTAB          00000000 009446 00009a 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  y (purecode), p (processor specific)



$ size image
   text    data     bss     dec     hex filename
   8076      52    6072   14200    3778 image
$ ls -l image.bin
-rwxr-xr-x  1 root  staff  8128  7  9 16:51 image.bin
```

## hello.c 예제
```shell
$ gcc -E hello.c
$ gcc -S hello.c
$ gcc -c hello.s
//이때 hello.o 파일이 생성된다.
$ file hello.o
hello.o: Mach-O 64-bit object x86_64
$ cc hello.o
$ ls
...
a.out
...
$ ./a.out
hello
```
## 오브젝트 파일과 실행 파일의 차이 공부!
```shell
//오브젝트 파일의 내용을 살펴보자
$ gobjdump -d hello.o
hello.o:     file format mach-o-x86-64
hello.o
architecture: i386:x86-64, flags 0x00000011:
HAS_RELOC, HAS_SYMS
start address 0x0000000000000000

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .text         00000031  0000000000000000  0000000000000000  00000270  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, CODE
  1 .data         00000004  0000000000000034  0000000000000034  000002a4  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  2 .cstring      00000007  0000000000000038  0000000000000038  000002a8  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 __LD.__compact_unwind 00000020  0000000000000040  0000000000000040  000002b0  2**3
                  CONTENTS, RELOC, DEBUGGING
  4 .eh_frame     00000040  0000000000000060  0000000000000060  000002d0  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
SYMBOL TABLE:
0000000000000034 g       0f SECT   02 0000 [.data] _a
0000000000000000 g       0f SECT   01 0000 [.text] _main
0000000000000004         01 COM    00 0200 _b
0000000000000028         01 COM    00 0400 _c
0000000000000000 g       01 UND    00 0000 _printf


RELOCATION RECORDS FOR [.text]:
OFFSET           TYPE              VALUE 
0000000000000020 BRANCH32          _printf
000000000000000b DISP32            .cstring-0x0000000000000038


RELOCATION RECORDS FOR [__LD.__compact_unwind]:
OFFSET           TYPE              VALUE 
0000000000000000 64                .text
```


```shell
//이전의 오브젝트 파일과 실행 파일의 비교
$ gobjdump -d a.out
a.out:     file format mach-o-x86-64
a.out
architecture: i386:x86-64, flags 0x00000012:
EXEC_P, HAS_SYMS
start address 0x0000000100000f50

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .text         00000031  0000000100000f50  0000000100000f50  00000f50  2**4
                  CONTENTS, ALLOC, LOAD, CODE
  1 __TEXT.__stubs 00000006  0000000100000f82  0000000100000f82  00000f82  2**1
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  2 __TEXT.__stub_helper 0000001a  0000000100000f88  0000000100000f88  00000f88  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  3 .cstring      00000007  0000000100000fa2  0000000100000fa2  00000fa2  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 __TEXT.__unwind_info 00000048  0000000100000fac  0000000100000fac  00000fac  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  5 __DATA.__nl_symbol_ptr 00000010  0000000100001000  0000000100001000  00001000  2**3
                  CONTENTS, ALLOC, LOAD, DATA
  6 __DATA.__la_symbol_ptr 00000008  0000000100001010  0000000100001010  00001010  2**3
                  CONTENTS, ALLOC, LOAD, DATA
  7 .data         00000004  0000000100001018  0000000100001018  00001018  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  8 __DATA.__common 00000038  0000000100001020  0000000100001020  00000000  2**4
                  ALLOC
SYMBOL TABLE:
0000000100000000 g       0f SECT   01 0010 [.text] __mh_execute_header
0000000100001018 g       0f SECT   08 0000 [.data] _a
0000000100001020 g       0f SECT   09 0000 [__DATA.__common] _b
0000000100001030 g       0f SECT   09 0000 [__DATA.__common] _c
0000000100000f50 g       0f SECT   01 0000 [.text] _main
0000000000000000 g       01 UND    00 0100 _printf
0000000000000000 g       01 UND    00 0100 dyld_stub_binder
```



```shell
$ xxd hello.o  => 이진수 파일을 16진수로 출력해줌 -r을 주면 반대로
00000000: cffa edfe 0700 0001 0300 0000 0100 0000  ................
00000010: 0400 0000 0002 0000 0020 0000 0000 0000  ......... ......
00000020: 1900 0000 8801 0000 0000 0000 0000 0000  ................
00000030: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000040: 9800 0000 0000 0000 2002 0000 0000 0000  ........ .......
00000050: 9800 0000 0000 0000 0700 0000 0700 0000  ................
00000060: 0400 0000 0000 0000 5f5f 7465 7874 0000  ........__text..
00000070: 0000 0000 0000 0000 5f5f 5445 5854 0000  ........__TEXT..
00000080: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000090: 2a00 0000 0000 0000 2002 0000 0400 0000  *....... .......
000000a0: b802 0000 0200 0000 0004 0080 0000 0000  ................
000000b0: 0000 0000 0000 0000 5f5f 6373 7472 696e  ........__cstrin
000000c0: 6700 0000 0000 0000 5f5f 5445 5854 0000  g.......__TEXT..
000000d0: 0000 0000 0000 0000 2a00 0000 0000 0000  ........*.......
000000e0: 0700 0000 0000 0000 4a02 0000 0000 0000  ........J.......
000000f0: 0000 0000 0000 0000 0200 0000 0000 0000  ................
00000100: 0000 0000 0000 0000 5f5f 636f 6d70 6163  ........__compac
00000110: 745f 756e 7769 6e64 5f5f 4c44 0000 0000  t_unwind__LD....
00000120: 0000 0000 0000 0000 3800 0000 0000 0000  ........8.......
00000130: 2000 0000 0000 0000 5802 0000 0300 0000   .......X.......
00000140: c802 0000 0100 0000 0000 0002 0000 0000  ................
00000150: 0000 0000 0000 0000 5f5f 6568 5f66 7261  ........__eh_fra
00000160: 6d65 0000 0000 0000 5f5f 5445 5854 0000  me......__TEXT..
00000170: 0000 0000 0000 0000 5800 0000 0000 0000  ........X.......
00000180: 4000 0000 0000 0000 7802 0000 0300 0000  @.......x.......
00000190: 0000 0000 0000 0000 0b00 0068 0000 0000  ...........h....
000001a0: 0000 0000 0000 0000 2400 0000 1000 0000  ........$.......
000001b0: 000d 0a00 0000 0000 0200 0000 1800 0000  ................
000001c0: d002 0000 0200 0000 f002 0000 1000 0000  ................
000001d0: 0b00 0000 5000 0000 0000 0000 0000 0000  ....P...........
000001e0: 0000 0000 0100 0000 0100 0000 0100 0000  ................
000001f0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000200: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000210: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000220: 5548 89e5 4883 ec10 488d 3d1b 0000 00c7  UH..H...H.=.....
00000230: 45fc 0000 0000 b000 e800 0000 0031 c989  E............1..
00000240: 45f8 89c8 4883 c410 5dc3 6865 6c6c 6f0a  E...H...].hello.
00000250: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000260: 2a00 0000 0000 0001 0000 0000 0000 0000  *...............
00000270: 0000 0000 0000 0000 1400 0000 0000 0000  ................
00000280: 017a 5200 0178 1001 100c 0708 9001 0000  .zR..x..........
00000290: 2400 0000 1c00 0000 88ff ffff ffff ffff  $...............
000002a0: 2a00 0000 0000 0000 0041 0e10 8602 430d  *........A....C.
000002b0: 0600 0000 0000 0000 1900 0000 0100 002d  ...............-
000002c0: 0b00 0000 0200 0015 0000 0000 0100 0006  ................
000002d0: 0100 0000 0f01 0000 0000 0000 0000 0000  ................
000002e0: 0700 0000 0100 0000 0000 0000 0000 0000  ................
000002f0: 005f 6d61 696e 005f 7072 696e 7466 0000  ._main._printf..
```



## objdump 사용법

```shell
$ gobjdump -D -x -s -h 실행파일
```



## T32_simarm 예제
> 윈도우 에서 돌려야함. 맥에서 설치 가능 하긴 하나 아직은 필요 없는듯
1. t32marm.exe 실행
2. 나온창 다 닫고 밑으 콘솔에
  B:: RES
  B:: D.L
  B:: R
  B:: D.DUMP 0X20000000
  B:: D.LOAD .ELF *
3. 창하나 뜨면 ex 폴더의 image 파일 열기 (반드시 image여야함 .bin 이런거 말고)
4. F9 누르면 기계에 를 와따가따함
5. F3 누르면 다음 단계 진행
6. BL Main에 다다르면 F2해서 프로그램 실행이됨



## Memory structure
[여기를 보며 참고해보자](http://faculty.salina.k-state.edu/tim/CMST302/study_guide/topic4/storage_class.html)

```scheme
//stored in memory
.text
실행 가능한 명령어들이 저장된다.
.rodata(rdata,const) =>rodata(read only data)
constant, literal & symbolic constant 등이 저장된다.
.data
초기화 전역 변수
.bss
초기화 되지 않은 전역 변수
.heap
사용자 동적 메모리
.stack
지역 변수
```



> Texas instrument에 보면 각 section에 대해 이렇게 정의 되어 있다.
>
>  Initialized sections: .text, .const, .cinit, and .switch
>
> Uninitialized sections: .bss, .stack, and .sysmem
>
> • .text -- Used for program code.
>
> • .bss -- Used for uninitialized objects (global variables).
>
> • .data -- Used for initialized non-const objects (global variables).
>
> • .const -- Used for initialized const objects (string constants, variables declared const).
>
> • .cinit -- Used to initialize C global variables at startup.
>
> • .stack -- Used for the function call stack.
>
> • .sysmem - Used for the dynamic memory allocation pool.



###  Text Section

The text section of the program contains the executable instructions of the program. Thus, the program instruction counter is a pointer into the text section. Constants, such as the string constants of a [printf()](http://faculty.salina.k-state.edu/tim/CMST302/study_guide/topic1/IO.html#printf) statement are also stored in the text section of memory.

###  Data Section

The data section of memory if for global and static data that is initialized when declared. Since, the initial value of initialized variables is known in advance, all global or static variables are saved together in the executable file and the data block is loaded into memory directly from the executable file just like the text section.

###  Bss Section

The bss section, like the data section, is for storing global and static variables. The difference being that the bss section stores variables that were not initialized to a specific value when declared. Bss data is initialized to zero when the program starts.

###  Stack Section

The stack stores various pointer values which are needed for the execution of the program and also is the default storage location for variables which are local to a function, i.e., declared within the body of the function. The stack data is created when program begins a function and is destroyed when that function exits. When the running function call another function, the new function’s data is pushed in front of the original function’s data.



### Memory section

> 프로그램이 run 할때까지의 memory section에 대한 이해를 해야한다.
>
> 사실 프로그램이 실행될때의 memory 구조를 주의깊게 보자.



![compile_bic](../../assets/img/post/compile_bic.png)

* a.c

![image-20180713120459967](../../assets/img/post/image-20180713120459967.png)

  a.c를 살펴 보면 code block 내에 존재하는 code들이 있다.

  ```c
  int li = 0x123456789;
  int lni;
  //두 변수의 설명에 automatic variable 이라고 설명 되어 있다.
  ```

Automatic variable 이란 특정 scope내에서 자동 생성 되어 stack에 저장되었다가

scope 를 빠져 나가면 stackd에서 자동 삭제 된다.

따라서 automatic variable들의 life time은 scope 를 벗어 날때 까지 이다.

  

* Load view & Exec view

![image-20180713120739413](../../assets/img/post/image-20180713120739413.png)

<center>Load and Exec view</centet>

Load view : a.out이 실행되기 이전에 ROM에 저장되어 있는 상태이다.

Exec view : a.out이 실행되서 RAM에 올라가 있을때 이다.

Zero Initialization : 초기화 되지 안은 전역 변수, 배열을 초기화 해준다.





* Memory segment example

![compile_scope](../../assets/img/post/compile_scope.png)




## Tips

## C언어

* 대입 연산자(=)는 반드시 일치 시키는것이 좋다.  

  int 형에 소수를 저장하는 형태를 살펴보자.  

  ```c
  int a=3.5;
  printf("%d",a);
  //실행결과
  3
  ```

  데이터 누수가 발생한다. int형은 소수부분을 저장하지 않는다. 때문에 0.5의 소수부분이 날라가버린다.  

  하지만 double형에 int형을 저장하는것은 가능하다.

  더 큰 자료형에 작은 형을 assign하는것은 문제가 없다 다만 자동 형변환이 일어난다.

* 강제 형변환 vs 자동 형변환

  * 자동 형변환

    자동 형변환은 더 작은 자료형에서 더큰 자료형으로 assign할때 발생.

    ```c
    int a=8,b=2;
    double b=a/b;
    printf("%f\n",b);
    //실행결과
    4.000000
    ```

    우리가 원하는 값은 4였을 터이지만 실제 출력값은 4.000000이 나온다.

    double은 8바이트를 할당하고 지수부분에 11비트 소수부분이 52비트를 저장한다.

    때문에 지수부분 4와 소수부분 52비트 즉 6바이트 0.000000 이기 때문에  

    소수점 밑으로 6자리를 표기한다.

  * 강제 형변환

    위와 같은 경우에서 원하는 값인 2로 표기할수도 있다.

    ```c
    printf("%d",(int)b);
    //실행결과
    4
    ```

    물론 강제 형변환은 포인터 에서도 많이 쓰인다.

    [함수 포인터](), [byte access](/study/lecture0615/#1byte-access) 를 참고.