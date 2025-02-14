---
title: "C언어 스터디"
date: 2018-06-11T04:22:12+06:00
description: C언어 관련 이론 정리
menu:
  sidebar:
    name: C언어 스터디
    identifier: study-c-language
    parent: sub-programming-language
    weight: 30
tags:
- Study
- C
- Theory
---

# C언어

프로그램이란? 컴퓨터에서 실행될때 특정 작업을 수행 하는 일련의 명령어들의 모음이다.

## 소프트웨어 공학

  - 요구사항 분석
    자료형 정의 등등
  - Flow chart 설계 및 구현(pseudo code)
  - 코드 구현
  - 실행
  - 테스트
  - 유지보수


## CPU 구조

  Control unit<->ALU<->Processor resister(R1,R2,R3...)
  위의 3가지 장치들이 Internal bus로 연결되어 통신한다.

  - ALU(Arithmetic logic unit )

    산술 논리 장치 : 실질적으로 산술, 논리 계산을 수행함.

  - Resister

    CPU의 자체적인 메모리저장 기능.

    Memory buffer register(MBR)

    ​	I/O로 보내지거나 메모리에 저장될 Word 혹은 I/O나 메모리로 부터 Word를 받는 것. 

    Memory address register(MAR)

    Instruction register(IR)

    Instruction buffer register(IBR)

    Program counter(PC)

    Accumulator (AC) and mutiplier quotient (MQ)

  - Control unit

    CPU의 명령어를 제어한다.




## 폰노이만 구조(최초의 컴퓨터 구조를 만듬)

  폰노이만의 구조는 CPU, 메모리, 프로그램 구조를 갖는 프로그램 내장 방식 컴퓨터를 뜻한다.


![cpu구조](https://upload.wikimedia.org/wikipedia/ko/a/a1/Von_Neumann_architecture_kor.png){: .center-image}
<center>폰노이만 구조(출처: 위키 백과사전)</center>



## C 메모리 구조

![c메모리 구조](https://1.bp.blogspot.com/-DoCFzIcQGDs/VlnGRLw69mI/AAAAAAAAAz0/xxrtrqK39FU/s1600/process%2Blooks%2Bin%2Bmemory.jpg){: width="50%" height="50%"}<center>(출처 : https://bitsofcomputer.blogspot.com/)</center>

  c언어에서의 메모리 구조를 알고 있다는것은 상당히 중요하다.

  주로 동적 할당 할때나 임베디드 시스템을 다룰때 메모리 구조와 영역을 알고 있으면 편하다.



### local variables
can be stored either on the stack or in a data segment depending on whether they are auto or static. (if neither auto or static is explicitly specified, auto is assumed)


### global variables
are stored in a data segment (unless the compiler can optimize them away, see const) and have visibility from the point of declaration to the end of the compilation unit.


### static variables
are stored in a data segment (again, unless the compiler can optimize them away) and have visibility from the point of declaration to the end of the enclosing scope. Global variables which are not static are also visible in other compilation units (see extern).


### auto variables
are always local and are stored on the stack.


### the register modifier
tells the compiler to do its best to keep the variable in a register if at all possible. Otherwise it is stored on the stack.


### extern variables
are stored in the data segment. The extern modifier tells the compiler that a different compilation unit is actually declaring the variable, so don't create another instance of it or there will be a name collision at link time.


### const variables
can be stored either on the stack or a readonly data segment depending on whether they are auto or static. However, if the compiler can determine that they cannot be referenced from a different compilation unit, or that your code is not using the address of the const variable, it is free to optimize it away (each reference can be replaced by the constant value). In that case it's not stored anywhere.


### the volatile modifier
tells the compiler that the value of a variable may change at anytime from external influences (usually hardware) so it should not try to optimize away any reloads from memory into a register when that variable is referenced. This implies static storage.




[geeks를 참고 하면서 공부해보자](https://www.geeksforgeeks.org/memory-layout-of-c-program/)

[Storage class in C](https://www.geeksforgeeks.org/storage-classes-in-c/)

  

## 컴파일 과정

- gcc compiler

  source.c -------> source.i -------> source.s -------> source.o -------> source

  ​         (precompile)       (compiler)         (assembler)           (linker)

![gcccompile](https://www3.ntu.edu.sg/home/ehchua/programming/cpp/images/GCC_CompilationProcess.png)
<center>gcc compile 과정 (출처: 제타위키)</center>

```shell
$ gcc test.c
$ ls
 a.out 실행 파일 생성
$ gcc -c test.c
 test.o 오브젝트 파일 생성
$ gcc -o test.out test.o 
 test.out 실행 파일이 생성됨
$ gcc -v --save-temps -o test.out test.c 컴파일 전체 과정을 보여주고 파일을 저장해줌
    test.c test.i test.s test.o test.out
```

## C Concept

일단 이부분은 [ISO/IEC 9899:TC3](http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf) 의 표준을 보고 작성하였다.

### scope
scope에 자세히 들어가기 전에 먼저 선행되야 하는 개념이있다.
```c
    int    i=0;
    선언자  식별자
```
코딩을 하면서 `int i` 정수형 변수 선언은 그냥 자연스레 넘어갔었다.

하지만 scope를 이해하기 위해서 더욱 자세하게 파고들어 보자.

두가지 개념을 살펴보자.

#### Declarator

  선언자 라고 하며, Type declarator라고도 한다.

  선언자의 역할은 변수의 형을 지정 하는것이다.

  위의 예제에 적용해 보자면 `int` 는 정수형 선언자 이다.

#### Identifier
식별자 라고하며, 형선언자로 인해 특정 데이터 형을 가질수 있는 변수가 된다.

`int` 는 Type sepcifier(형식 지정자) 라고 한다.

즉, `i` 는 `int` 형 변수에 대한 식별자이다.

하지만 식별자는 반드시 변수에만 해당하는 것은 아니다.

예를 들어 `void main` main은 void형 함수에 대한 식별자 이며,

`printf()` 는 printf 함수에 대한 식별자 이다.

#### Visible

식별자는 오직 자신이 존재 하는 scope안에서만 사용될수 있다.

`Inner Scope` , `Outer Scope`의 개념을 이해 하는게 편할것 같다.

예제를 살펴 보자.

```c
#include <stdio.h>
int glo=10;
void main(){ //scope 1
  int a=3;
  
  { //scope 2
    int b=4;
    { //scope 3
      int c=8;
      printf("a: %d  b: %d  c: %d glo: %d\n",a,b,c,glo );
    }
    printf("a: %d  b: %d  c: %d glo: %d\n",a,b,c,glo );
  }
printf("a: %d  b: %d  c: %d glo: %d\n",a,b,c,glo );
}
```

이제 결과를 예상해 보자. 여태 배운 대로 라면 Inner scope 에서 선언된 식별자는

outer scope에서 사용할수 없다. 그렇다면 scope 2 에서는 scope3 의 정수형 식별자

c를 사용할수 없고, scope 1 에서는 정수형 식별자 b,c를 사용할수 없다.

그럼 결과를 보자.

```c
test.c:12:48: error: use of undeclared identifier 'c'
    printf("a: %d  b: %d  c: %d glo: %d\n",a,b,c,glo );
                                               ^
test.c:14:42: error: use of undeclared identifier 'b'
printf("a: %d  b: %d  c: %d glo: %d\n",a,b,c,glo );
                                         ^
test.c:14:44: error: use of undeclared identifier 'c'
printf("a: %d  b: %d  c: %d glo: %d\n",a,b,c,glo );
```

당연히 outer scope에서 inner scope의 식별자를 사용하는것은 불가능하다.

때문에 scope 2 에서는 scope 3 의 식별자를 사용할수 없고,

scope 1 에서는 scope 2, scope 3 의 식별자를 사용할수 없다.

`C99` 표준에 서는  Scope 에 대해 다음과 같이 정의하고 있다.

> If so, the scope of one entity (the inner scope) will be a strict subset of the scope of the other entity (the outer scope). 
>
> Within the inner scope, the identifier designates the entity declared in the inner scope; the entity declared in the outer scope is hidden (and not visible) within the inner scope.

#### Valid scope

같은 이름과 형식(Same entities)의 식별자 들은 다른 scope에서 사용되거나,

다른 파일(Different name space)에서 사용되어야 한다.

#### Variety of Identifier

각 종류의 식별자는 그 자체의 scope를 가진다.
    

##### function : 함수 내부에서의 식별자 

function은 자체의 code block `{}` 안에서 선언된 식별자는

해당 scope안에서만 사용될수 있으며, global, static 의 속성이 없으면,

해당 scope 밖의 식별자를 사용할수 없다.

##### function prototype : 함수 선언 parameter에서의 식별자

예를 들어 fuction을 선언 하고 사용 하기 위해선 

전처리 부분에 function에 대한 정보를 알려줘야 한다.

예제를 보자

```c
#include <stdio.h>
int add(int a,int b); // Function prototype
int main(){
  int a=1;
  printf("%d\n",add(a,a));
}

int add(int a, int b){
  return a+b;
}
```

function prototype 안에서의 `int a`와 main함수 scope안의 `int a` 는 

중복 되지만 문제 되지 않는 이유는, 서로 다른 inner scope이기 때문에 

서로 영향을 주지 않는다.


##### file : 서로 다른 파일내부의 식별자


##### block : code block내의 식별자

file scope 와 block 은 다음 예제를 보고 이해해 보자.

  ```c
   //In add.c
    #include <stdio.h>
    extern int test;
    int add(int a,int b); // Function prototype
    void main() //main도 main함수의 식별자 이다.
    {
      int i=1; //main 함수 code block안에 있는 정수형 식별자 i이다.
      // 즉 main function 안에 존재 하는 정수형 식별자 이다.
      int result=0;
      { // code block
        int b=10;
        printf("i+b: %d\n",i+b);
      }
      result = add(i,i); //add도 add함수의 식별자 이름이다.
      printf("%d",result); //printf 도 printf함수의 식별자
      printf("%d",test); 
    }
    
    int add(int a, int b){ // add function내부에서 사용하는 함수 a,b 이다.
      return a+b; 
    }
    
    //In sub.c
    //sub.c로 건너 오면 같은 이름의 식별자도 다른 name space에 존재하기 때문에
    // 서로 영향을 주지 안는다.
    #include <stdio.h>
    static int result =0; //여기에 왜 static을 붙였을까?
    int test=100;
    int sub(int a,int b);
    void main()
    {
      int i=1; // add.c를 벗어난 다른 name space에서 사용된 같은 이름의 식별자이다.
      result = sub(i,i);
      printf("%d",result);
    }
    
    int add(int a, int b){
      return a-b;
    }
  ```

위의 코드를 살펴 보면 특이 부분이 있다.

##### static

add.c 와 sub.c의 전역 변수중에 이름이 같은게 있다.

두변수의 이름은 모두 result 이다. 하지만 해당 코드들은 실행시 에러가 발생하지 않는다.

왜일까?

예상 대로 라면 같은 이름의 전역변수는 data segment에서 충돌될것이다.

하지만 전역변수에 staitc을 붙여 주면, 해당 전역 변수는

해당 파일의 file scope를 벗어나지 못한다.

때문에 sub.c의 result 는 sub file의 file scope 가 끝남과 동시에

메모리에서 해제 된다.



##### extern

add.c 를 보면 `extern int test` 를 하고 있다. 

뭘까? test 식별자는 add.c file scope 내에는 존재하지 않는다.

하지만 sub.c 를 보면 전역 변수로 `int test=100` 이 존재 한다.

그럼 이제 어느정도 감이 왔을겄이다.

extern은 file scope를 벗어나서 다른 file scope내에 있는

전역 변수를 사용하고자 할때 쓰는것.

> extren 은 다른 file scope 의 전역 변수의 사용을 가능케 한다.

그럼 이제 예시를 살펴보자.

```c
//t1.c
#include <stdio.h>
#include "t.h"
extern int test;
int main(){

  printf("%d\n",test );
  test+=1;
  printf("%d\n",test );
  add();
}

//t2.c
#include <stdio.h>
#include "t.h"
int test=100;

void add(int i){
  printf("%d\n",test );
}

//t.h
void add();

```
t1.c 는 t2.c 의 test를 가져 와서 출력후 1증가 한후 다시 출력해준다.

그리고 add 함수를 호출하는데, 이 함수는 t2.c에 있다.

그럼 t1.c에서 1을 증가 시켰던 test값이 t2.c에서 그대로 적용되는지 확인해 보는 예제이다.

그럼 결과를 살펴 보자

```c
100
101
101
```

물론 t1.c에서 증가 시켰던 test의 값이 t2.c에서도 그대로 적용되었다.

이러한 현상을 `linkage` 라고 한다.

메모리에는 어떻게 저장되어 있을까?

![image-20180713142020491](./images/image-20180713142020491.png)

data segment 에 저장되어 있다.

extern으로 선언자를 지정해도 결국 초기화된 전역 변수 이므로 data segment에 저장된다.



이제 scope에 대해 어느정도 이해를 했을 것이다.

추후 내용에 `Parameter` 와 `Argument` 에 대한 내용이 나온다.

이둘의 관계처럼 선언자와 식별자의 관계는 중요하다.






## 상수, 변수

변수(Variable) : 정수, 실수, 문자, 문자열 등의 형태를 갖춘 가변 데이터.

>변수는 두가지 특징을 갖는다.
>
>Scope - 특정 code block 안에서 실행, 참조된다.
>
>Life time - 특정 code block안에서 존재하고 벗어나면 소멸 한다



  1. 일반 변수

     일반적으로 사용하는 자료형에 해당하는 대입 변수이다.

     ```c
     //일반 변수 = 데이터
     int a=4;
     double b=3.2;
     char p='a';
     ```

     

  2. 포인터 변수

     ```c
     int temp_int=4;
     double temp_d=3.4;
     //포인터 변수 = 주소
     int *a=&temp_int;
     int *c=&3;
     double *b=&temp_d;
     char *p="abc";
     ```

     

- 상수(Constant) : 값이 바뀌지 않는 데이터를 상수라 한다.

  1. 변수 상수화

     변수 앞에 const를 붙여주면 상수가 된다.

     const int a; => 상수로 정해진 변수는 값을 바꾸는것이 불가

  2. 매크로를 통한 상수화

     `# define` 을 통해서 상수를 만들수 있다. 매크로는 전처리기에 의해 변환 되고

     전역변수 처럼 사용 가능 하다. 위치는 헤더 파일 제일 밑에 사용해주면된다.

     ```c
     #include <stdio.h>
     #define pi 3.14
     #define poweroftwo 2
     ```

     

  ex) 정수 상수 => -2,-1,0,1,2,3....

  ​      실수 상수 => -1.2, -0.2231, 3.14...

  ​      문자 상수 => '1', '2' ,'ㄱ','A','a'...

  ​      문자열 상수 => "abc", "ABC"...

  1. 정수형 상수의 컴파일후의 비트 형태

     정수형 상수는 컴파일되면 4바이트 크기의 2진수 형태로 변환 된다.

     예를 들어 정수 13이 컴파일 되면, 나머지 비트는 0으로 채워 지게 됩니다.

     ```c
     0000 0000  0000 0000  0000 0000  0000 1101
     <--MSB                              LSB-->
     ```

     여기서 중요한 개념이 나옵니다. MSB와 LSB가 무었인가

     MSB는 `Most significant bit` 라 하며 가장 왼쪽의 비트는 전체 값에서 가장 큰 비중을 차지한다.

     LSB는 `Least significant bit` 라 하며 가장 오른쪽의 비트는 전체 값에서 가장 작은 비중을 차지한다.

     예를 들어,

     ```c
     1000 0000(128)  >  0111 1111(127)
     극단 적인 예로 128과 127의 차이를 보면된다.
     뇌피셜로는 비트가 1인 비트가 많을수록 숫자가 크다.
     물론 맞는 말이지만 모든경우에 해당되지는 안는다.
     위의 예처럼 오른쪽 7비트가 전부 1인 값보다 가장 왼쪽 1비트가 1인 값이 크다.
     ```

     그렇다면, 비트가 큰값으로 움직일때는 MSB의 움직임을 보면될것이다. 만약 작은 단위로   

     비트가 움직여야 한다면, LSB를 보면 되는데 이때 한가지 예를 살펴봐야 한다.

     ```c
     (0x8E)1000 1101(141)   -->   (0x8D)1000 1110(142)
     1가장 왼쪽 LSB의 1비트 움직임을 보일때 Niddle단위로 비트가 이동한다고 한다.
     ```

  2. 실수형 상수의 컴파일후의 비트 형태

     single, double, quad 세가지 형태가 있고, 그중에서 double형태를 살펴본다.

     ```c
       0          00000000000      00000...       
     부호비트(1)   지수 저장 비트(11)	  소수 저장 비트(52) => 8byte(64bit) 
      //소소부
        1    1    1  ...
      2^-1 2^-2 2^-3 ...
      위의 예시처럼 소수부는 2의 -n제곱의 형태를 띈다.
      때문에 소수르 사용한 계산은 정확하지 안을수 있다.
      2^-1 => 1/2 이고 0.5이다.
      2^-2 => 1/4 이고 0.25이다
      2^-3 => 1/8 이고 0.125이다.
      소수부분이 5의 나머지 연산으로 처리 되는점을 보면, 0.3 같은 표현은 다루기 힘들다.
     ```

     

     

## 강제 형변환 vs 자동 형변환


  - 자동 형변환

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

  - 강제 형변환

    위와 같은 경우에서 원하는 값인 2로 표기할수도 있다.

    ```c
    printf("%d",(int)b);
    //실행결과
    4
    ```

    물론 강제 형변환은 포인터 에서도 많이 쓰인다.

    [함수 포인터](), [byte access](/study/lecture0615/#1byte-access) 를 참고.

## 전달 인자(Argument)와 매개변수(Parapeter)

```c
int   *a  =  &temp;
    매개변수   전달인자
int add(int *a){}
         매개변수
add(&temp);
    전달인자
```



## LIttle and Big Endian

```c
int a=1; => 0x 00 00 00 01
   Little    Big
|___01___|___00___| 0x7fff2ab9
|___00___|___00___|
|___00___|___00___|
|___00___|___01___|
|________|________|
```

시스템마다 little endian, big endian 두가지 방법중 하나를 채택한다.

하지만 다양한 종류의 컴퓨터들끼리 통신을 해야 하는데, 이때 데이터를 읽어서 저장하는 방법이  

다르다면 문제가 생긴다 때문에, 한가지로 통일해 줘야 한다.

이떄 사용 되는 방법이 [Byte Access](/study/lecture0615/#1byte-access)이다

## Digital logic circuit(DLD)





## Bitwise

* 특정 비트 on/off

  예를들어 Led의 한부분을 껏다 켯다 하는 동작이 발생할수도 있다.

  LED와 연결되어 있는 특정 주소의 값에 한 비트를 on/off해야 동작 할때

  다음과 같은 비트 연산으로 수행 가능하다.

  ```c
  res => 0x 1111 0111
  res&=~(0x01 << 7);
    0111 1111 (~res)
  & 1111 0111 (res)
  _____________
    0111 0111 => 가장 오른쪽 1비트만 off가 되었다
  이처럼 특정 비트를 on/off할때에 ~(not)과 &(and)연산이 필요하다.
  ```

  



## Basic of Loop

프로그래밍중에 실수와 의도에 의해서 무한 루프가 발생하거나 써야 하는 일이 있다.

1. 의도치 않은 무한 루프

   대부분 세미 콜론이나, 조건식을 잘못 써서 발생한다.

   ```c
   //case1
   int val=0;
   while(val<5); => while문의 내용이 시작하기 전에 세미콜론을 사용하였다.
   {
       printf("a\n");
   }
   
   결과는 물론 무한 루프이다.
   while 문의 조건식을 잘못 적용 하였고 루프에 빠지게 될텐데,
   while 문의 내용이 시작하기 전에 세미 콜론으로 마무리 했다.
   때문에 printf 는 while 문의 무한 루프 때문에 출력이 되질 않는다.
   //case2
   int val=0;
   for(val=0;val<5;val++); => for문의 내용이 시작도 전에 세미콜론이 찍혔다.
   {
   printf("aa\n");
   }
   이번엔 어떨까? aa가 5번 찍히는가? 아니다.
   for문의 내용이 시작도전에 세미콜론이 있기 때문에, for문만 5번 돌아가고나서
   printf 는 한번만 사용된다. 즉 aa는 한번만 출력되는것!!
   그럼 중괄호('{}')의 역할은 뭘까?
   보통 중괄호는 코드의 영역을 나타낸다.
   ```

2. 의도한 루프

   Firmware 등의 기본 동작에 필요한 경우가 있다. 혹은 지연 시간을 위해 고의적으로 넣는 경우도  

   있는데, 지금은 펌웨어에서 필요로 하는 Polling 방식에 대해 기술해 보려 한다.

   * Polling

     폴링방식은 하나의 프로그램에서 상태를 주기적으로 체크하여, 조건에 해당될때 송수신하는 목적이다.

     예를 들어 보자, 세탁기 같은 내장프로그램을 봤을때, 시작과 종료 후에 다시 시작을 눌러도  

     기계는 작동한다. 이는 폴링 방식에 의해서 주기적으로 루프를 돌고 있기 때문이다.

     ```c
     while(1){
         조건1
         조건2
         조건3
         ...
     }
     프로그램은 계속해서 주기적으로 조건이 만족한 명령을 수행후 다시 while 문 의 처음으로
     돌아와서 처리한다.
     ```

     

   * Interrupt

     인터럽트 방식은 특정 이벤트가 발생했을때 동작을 멈추고 해당 이벤트를 처리하는것

     주로 OS를 대표적인 예로 들수 있다. 만약 종료라는 이벤트가 발생한다면, cpu는 그즉시

     모든 연산을 멈추고 종료를 처리한다.

     물론 인터럽트 방식은 예기치 못한 상황에 대비할때 좋은 방법이다.

## Array

배열은 자료형의 집합이라고 생각할수 있다. 배열은 메모리 Stack 에 할당되며, main부분에 사용된

배열은 프로그램 시작에 생성되고 종료시 삭제 된다. 하지만 함수 부분에서 사용한 배열은 함수 종료와 함께 사라진다. 때문에 동적할당의 필요성이 대두 될때가있다.

```c
int arr[5];
여기서 int 는 배열의 자료형이고
arr은 배열명이다.
```

이제는 배열을 활용하는법을 알아야 한다.

배열에 접근해서 직접 자료를 처리해서 프로그래밍을 해야한다.

때문에 배열에 접근 하는 방법을 알필요가 있다.

1. 직접 접근(Direct access)

   배열에 직접적으로 접근하는 방법이다.

   ```c
   arr[0]=5;
   printf("%d\n",arr[1]);
   ```

   

2. 간접 접근(Indirect access)

   *(Asteric)에 관한 표현이 나오는데 이는 포인터의 개념이다.

   해당 주소의 값을 가져 온다고 생각 하면 된다.

   ```c
   *arr=5;
   printf("%d\n",*(arr+1))
   ```

이제 배열을 사용하면서 주의해야 할사항들이 있다.

```c
int arr[5];
     arr       !=    arr[0]
배열의 시작 주소       배열의 0번째 값
    *arr      ==   &arr[0]
배열의 시작 주소       배열의 0번째 주소
배열의 시작 주소는 배열의 0번째 주소화 일치한다
```

arr이라는 배열명은 수정 불가능한 포인터 상수이다.

만약  inr arr[5]; 선언후, arr의 주소가 0x2000번지 일때 0x3000번지로 수정하는것 불가!

배열은 한번 스택에 할당 되면 고정된다.

배열의 각 요소 들간의 차이는 배열의 자료형의 크기에 달려 있다.

```c
arr[0]   ->   arr[1]   ->    arr[2]
0x0200  4byte 0x0204  4byte  0x0208
```



## Shallow copy(얕은 복사) vs Deep copy(깊은 복사)

* Shallow copy(얕은 복사)
* Deep copy(깊은 복사)





## Function

함수는 3가지 단계이자 요소가 필요하다.

1. 함수의 원형

   main문 시작전에 전저리 부분 다음에 기술해줘야 한다.

   ```c
   #include <stdio.h>
   void display();
   int add(int a,int b);
   ```

   위의 예시처럼 원형을 기술할 때에는 매개변수부분은 써줘도되고 안써줘도 된다.

2. 함수의 호출

   ```c
   int main(){
       int res=0;
       int a=3,b=10;
       display();
       res=add(10,20);
       printf("%d",add(a,b));
   }
   ```

   

3. 함수의 정의

   ```c
   void display(int *ptr,int idx){
       for(int i=0;i<idx;i++)
           printf("%d has %d\n",i,*(ptr+i));
   }
   ```

   

## Pointer

포인터라 하면 c언어의 포기하는 break point일지도 모른다. 하지만 포인터를 활용 하지못한다면

다양항 프로그래밍이 불가능 하다 포인터 부분은 자다가도 벌떡 일어나서 정의할수 있어야한다.

> 주소 연산자(&)

&(Ampersand) 엔드 연산자, 주소연산자 등등으로 불린다. 정확한 명칭은 Ampersand이다.  

주소 연산자는 해당 변수, 함수 등의 주소를 확인할수 있게 합니다.

주소에 대해 생소할수 있습니다. 프로그램 실행시에 컴파일러에 의해 메모리에 각 영역에 따른 변수나 함수 등이 할당됩니다. 첫번째 예는 변수 입니다.



* Local & Gloal Variable

  Local Variable은 지역 변수라고도 하며, 해당 함수 범위 내에서만 사용할수 있는 변수입니다.

  Global Variable은 전역 변수 라고도 하며, 코드 내의 그 어떤 부분에서도 사용할수 있습니다.

  이제 두변수의 사용 예를 살펴보려 합니다.

```c
int global_b=10;
int main(){

    int local_a=10;
    static int global_a=20;
    printf("In main funtion local variable local_a has %d\n",local_a );
    printf("In main funtion local variable local_a address %p\n",&local_a );
    printf("In main funtion static global_a has %d\n",global_a );
    printf("In main funtion static global_a address %p\n",&global_a );
    printf("In main funtion global variable global_b has %d\n",global_b );
    printf("In main funtion global variable global_b address %p\n",&global_b );
    local_func(local_a,global_a);
    point_func(&local_a);
    printf("%d\n",local_a);
}

void local_func(int a,int b){
    printf("In local funtion printf local_a has: %d address: %p\n\n",a,&a);
    printf("In local funtion printf global_a has: %d address: %p\n\n",b,&b);
    printf("In local funtion printf global_b has: %d address: %p\nbut not using parameter\n",global_b,&global_b);
    a=10;
    printf("a=10;\nlocal_a change 10 to 20 not using poiter\n");
}
void point_func(int *p){
    *p=100;
}
```

> 메인 함수에서 local_a와 global_a를 선합니다. 하지만 global_a는 앞에 static이 붙습니다.
>
> 왜일까요? 바로 전역 변수 처럼 사용하기 위합입니다. 변수 앞에 static을 붙이면 전역 변수 저장 영역인 data영역에 할당됩니다. 마치 전역변수 처럼요.

```c
In main funtion local variable local_a has 10
In main funtion local variable local_a address 0x7ffeed43898c
In main funtion static global_a has 20
In main funtion static global_a address 0x1027c801c
In main funtion global variable global_b has 10
In main funtion global variable global_b address 0x1027c8018
    
//into local_fun
In local funtion printf local_a has: 10 address: 0x7ffeed43894c
In local funtion printf global_a has: 20 address: 0x7ffeed438948
In local funtion printf global_b has: 10 address: 0x1027c8018
but not using parameter
a=20;
local_a change 10 to 20 not using pointer
//end local_func
after local_func, a has 10 

local_a passing by point_func
//into point_func
In point_func change local_a 10 to 100
//end point_func
    
after point_func, Now local_a has 100
```

local_func에서 local_a의 값을 변화 시키려 했지만 메인 함수에서 local_a의 값을 출력해보니 그대로 입니다. 왜일까요?

local_fun는 전달 인자를 int a로 받았습니다. 이러한 매개변수는 값의 복사가 발생합니다.

바로 `call by value` 의 상황이죠. 즉, 메모리에 변수의 복사가 발생하고, 이 변수는 함수의 종료와

동시에 바로 삭제 됩니다.

  

### call by value

```c
int main(){
    int local_a=10;
    static int global_a=20;
    local_func(local_a,global_a);
}

void local_func(int a,int b){ => 변수의 값을 함수의 변수로 복사하는것입니다.
    a=20; =>함수 내부의 변수는 함수의 시작과 동시에 생성되고 종료와 함께 반환됩니다.
    b=400;
}
```

Call by value는 매개변수로 값을 받아와 함수의 메모리로 복사해오는것 입니다.

그래서 함수내부에서 아무리 값을 바꿔도, 실상은 함수로 복사된 값을 변환하는 것이므로,

본래의 전달인자로 들어온 변수는 그대로입니다.

그럼 본래 변수의 값을 바꾸려면 어떻게 해야할까요?  



###  call by reference(call by address)

사실 C에서는 Call by reference 가 완벽하게 작동하지는 않습니다.  

아이라 폴과 알켈리의 `A Book on C` 에서 P.252 의 call by reference 를 언급하자면,

> How the used of addresses of variables as arguments to functions can produce  
>
> the effect of "call by reference".

라고 명시되어 있습니다.

다른 언어에서는 call by reference의 mechanism이 존재 하지만 C에서는 존재 하지 않습니다.

하지만 비슷한 동작을 할수 있게끔 만들어줄수는 있습니다. 일단 예제를 보죠.

```c
int main(){
    int a=3, b=7;
    printf("a: %d  b: %d\n",a,b);
    swap(&a,&b);
    printf("a: %d  b: %d\n",a,b);
}

void swap(int *a, int *b){
    int temp;
    temp=*a;
    *a=*b;
    *b=temp; 
}
```

이전의 call by value에서는 함수에서의 값의 복사 때문에 본래의 변수의 값은 변하지 안았습니다.

근데 이번 함수 swap은 매개변수(int *a)가 포인터이며, 전달인자(&a)를 변수의 주소를 받고있습니다.  

결과는 어떨까요?

```c
a: 3  b: 7
a: 7  b: 3
```

값의 변화가 있습니다. 뭘까요?

바로 call by reference의 효과 입니다. 변수의 주소를 전달 받아 직접 값을 바꾸는 것이죠.

하지만 `A Book on C`에서 언급했던 완벽한 call by reference가 아닌 이유가 여기있습니다.

사실상 주소를 전달받아 값을 바꾼 다는 것은, 주소의 값을 call by value한다는 것이죠.

잘 이해가 안가는데 다음 예제를 살펴보죠.

```c
//출처 : 나무위키
void testFunc(int* fptr) {
    fptr = NULL;
}
int main(void) {
    int num = 12;
    int* ptr = &num;
    printf("%d\n",*ptr );
    testFunc(ptr);
    printf("%d\n",*ptr );
    return 0;
}
```

testFunc라는 함수는 포인터를 인자로 받아 포인터의 값을 NULL로 바꿉니다.

자 그러면 코드를 어떻게 동작을 할까요?

메인 함수에서 ptr은 num 의 주소를 갖고 있습니다. 그리고 그 주소에 대한 값을 testFunc에  

전달 하고 있습니다. 그럼 testFunc를 완료 하고 나면 ptr에는 NULL이 저장 될테고,

더이상 num을 가르킬수 없습니다. 과연  결과도 그럴까요?

```c
12
12
```

예상과는 다르게 num의 값은 변하지 안았습니다.

이게 뭘 뜻하는 걸까요?

C에서는 주소값을 전달 받아 해당 주소로 이동후 값을 변화 할수 있지만, 그 과정에서 정확히는  

전달 인자로 포인터 변수를 전달한다. 즉, 포인터 변수 ptr을 전달 하므로 이는 `call by value`

라고 할수 있다. 그러므로 C에서는 `call by reference`는 없다고 정의 할수 있다.

다시 말해 함수에 인자를 받아 인자값 자체를 변화 시키는 것은 불가능 하다, 하지만 인자값의 주소로 건너가 그 값을 바꾸는 것은 가능하다, 하지만 이것은 값의 의한 복사 `call by value` 이다.

하지만 `call by value` 로 전달하는 `value` 가 주소값이 이기 때문에 `call by value` 라고 부는것!!

결론은  `call by reference`가 아니라 `call by address`  or  ` call by pointer` 

라고 불러야 한다.

그럼 진정한 call by reference는 어디에 존재하는 것이가?

바로 c++부터 그 개념이 등장한다.



### call by reference

c++ 에서는 참조 변수 라는 것이 존재한다.

```c
int a=10;
int &b=a;
```

c에서는 &(ampersand)는 주소 값의 반화을 의미했다. 하지만 c++에서는 참조 매개변수가 존재 하며

값을 복사 하는 `call by value` 가 아닌 주소 값을 받아와 참조에 의한 접근이 가능하다.

다음 c++ 예시를 살펴보자.

```c++
#include <stdio.h>
#include <iostream>
void func1(int *q);
void func2(int *q);
void func3(int &q);
int main(){
    int a=10;
    int *point=&a;
    printf("a address: %p  value: %d \n\n",&a,a);
    func1(&a);
    printf("After func1 a value: %d\n",a);
    printf("\n===================================\n");
    printf("point address:%p  point has : %p  value: %d \n",&point,point,*point );
    func2(point);
    printf("After func2 a value: %d\n",a);
    printf("\n===================================\n");
    printf("Now we declaration int &ref_point=a\n");
    int &ref_point=a;
    printf("point address:%p  point has : %p  value: %d \n",&point,point,*point );
    func3(ref_point);
    printf("After func3 a value: %d\n",a);

}
void func1(int *q){
    printf("In Func1\nNow we change value of a to 100\nSo q=20;\nif you think change the value?\n");
    //q=20;
    printf("q=20; is error occured\n");
    printf("q address: %p  value: %d \n",&q,*q);
    printf("a address: %p  value: %d \n",q,*q);
}
void func2(int *q){
    printf("In Func2\nNow we change value of a to 100\nSo *q=100;\nif you think change the value?\n");
    *q=100;
    printf("q address: %p  value: %d \n",&q,*q);
    printf("a address: %p  value: %d \n",q,*q);
}
void func3(int &q){
    printf("In Func3\nNow we change value of a to 100\nSo *q=3000;\nif you think change the value?\n");
    q=3000;
    printf("q address: %p  value: %d \n",&q,q);
}
```

내용이 복잡하다. 우선 각 함수들이 뭘하는 지를 살펴보자.

fun1~3까지의 함수가 존재하는데,

`func1`

```c++
//일반 적인 c에서의 call by address의 예시이다.
void func1(int *q){
    printf("In Func1\nNow we change value of a to 100\nSo q=20;\nif you think change the value?\n");
    //q=20; => 진정한 call by reference가 되려면 주소로 받아온 값을 바꿀수 있어야한다.
    printf("q=20; is error occured\n");
    printf("q address: %p  value: %d \n",&q,*q);
    printf("a address: %p  value: %d \n",q,*q);
}
```

func1은 매개변수로 포인터 변수 를 사용 하며, 전달 인자로 주소를받는다.

만약 q=20을 하면 어떻게 될까?

사실상 main함수에서 `int *point=&a;` 라고 선언했다는 것은

```c++
//예를 들어 변수 q는 0x2000에 존재 하며 a변수는 0x1000에 있다고 치자.
point == &a ==0x1000
&point == 0x2000(address of q q변수의 주소)
*point == a(a의 값 10)
```

이제 위의 내용을 머리속에 넣고 정신 단디 차리고 하나씩 해석해 보자.

먼저 func1에에서 전달 인자로 &a를 전달 했고 *q 포인터 변수로 받았다.

이때 무슨일이 생길까?

```c++
//In func1
//메인 함수에서 a의 주소를 전달 했다.
//그러면 func1함수에서는 함수 시작과 동시에 int *q에 대한 변수 공간을 생성한다.
//위에서 a변수의 주소는 0x1000이였다. 그렇다면 함수로 a의 주소를 전달하고 나서도
//그래도 a의 변수를 참조하여 접근이 가능할까?
//진정한 call by reference 라면 받아온 주소로 바로 접근이 가능해야할것이다.
//===============컴파일 결과==============
a address: 0x7ffee1f8173c  value: 10 
In Func1
Now we change value of a to 100
So q=20;
if you think change the value?
q=20; is error occured
q address: 0x7ffee1f816e8  value: 10 
a address: 0x7ffee1f8173c  value: 10 
After func1 a value: 10
```

결과를 살펴 보자.

우리가 원하는 결과는 받아온 a의 주소와 매개변수 q의 주소가 같아야한다.

근데 보아하니 주소값은 두개가 존재한다. 이건 뭘 뜻할까?

func1이 실행되는 순간  `int *q` 에 대한 변수 공간이 마련된다.

이곳은 주소는 `0x7ffee1f816e8` 이다. 그리고 해당 주소한에 들어있는 값이 `0x7ffee1f8173c(a의 주소)`이다.

즉 값에 의한 복사인 `call by value` 로 인해 a의 주소 값을 받아와 접근한다는것이다.

때문에 q안에는 a의 주소값인 `0x7ffee1f8173c` 이 들어 있고 ,

`q=20;` 이라는 재할당을 한다는 것은 q가 갖고는 있는 값을 20 으로 바꾼 다는 것이고,

q는 포인터 변수 이기 때문에 20의 주소에 있는 값을 가져와야 한다고 해석한다.

하지만 마음대로 메모리를 접근할수는 없다 컴파일 단계에서

이런 위험한 코드는 막아 버리기때문에 에러를 토해낸다.

결국 func1은 `call by value` 에 의한 함수 내부의 포인터 변수 공간에

전달 인자로 받아온 a의 주소를 저장 하여 a의 값에 접근 한다는것이다.

진정한 `call by reference`  는 실패 했다.



그럼 이제 두번째 함수 `func2` 를 살펴보자.

`func2`

```c++
void func2(int *q){
    printf("In Func2\nNow we change value of a to 100\nSo *q=100;\nif you think change the value?\n");
    *q=100;
    printf("q address: %p  value: %d \n",&q,*q);
    printf("a address: %p  value: %d \n",q,*q);
}
```

사실상 func1과 별 차이가 없다. 하지만 func2에서는 a의 변수를 포인터로 접근하여

값을 변경하기 때문에 a값의 변화가 생긴다. 

하지만 위에서 봤듯이 이는 `call by value` 에 의한 `call by reference` 를 흉내 낸것이다.

우리는 이러한 과정을 `call by address`  or  `call by pointer` 라고 부른다.

그럼 진정한 `call by reference` 는 어떻게 해야 볼수 있을까?

위에서 `데니스 리치` 의 말을 언급 하면 C에서는 `call by reference` 는 없다 .

하지만 C++에서는 참조 변수라는것이 존재한다.

이제 func3를 살펴 보자.



`func3`

```c++
int main(){
    int a=10;
    ...
    int &ref_point=a;
    func3(ref_point);
}

void func3(int &q){
    printf("In Func3\nNow we change value of a to 100\nSo *q=3000;\nif you think change the value?\n");
    q=3000;
    printf("q address: %p  value: %d \n",&q,q);
}
```

우리가 알던 C의 문법에서는 볼수 없는 변수 선언이 있다. 이게 뭘까 싶다.

일단 실행 결과를 살펴 보자.

```c++
===================================
Now we declaration int &ref_point=a
ref_point address:0x7ffeee79373c  ref_point has : 100 
In Func3
Now we change value of a to 3000
So q=3000;
if you think change the value?
q address: 0x7ffeee79373c  value: 3000 
After func3 a value: 3000
```

정말 신박함의 극을 달린다 할수 있다. `int &ref_point=a` 참조 변수에 a의 주소 값도 아닌

a를 할당 하고 있다. 그리고 ref_point의 주소를 출력해보니 ref_point의 별도의 변수 공간이 아닌

a의 주소를 출력하고 있다.

그럼 함수 안에서는 어떨까?

물론 q 변수에 대해서도 별도의 변수 공간을 할당하지 않는다.

함수내에서도 a의 주소 를 출력하고 있으며, q로 값을 3000으로 재할당한후,

함수가 종료되고 나서 a의 값을 출력해 보니 3000으로 바뀌어 있다.

진정한 `call by reference` 란 값에 의한 복사를 통해 변수에 접근하는 것이 아닌

> 값의 복사 없이 변수 자체에 접근 할수 있어야 한다는 것

그래서 데니스 리치는 `call by reference` 에 대해

> ..."call by reference"..., in which the called routine has access to the original argument, not a local copy.

"호출 과정 내에서 지역 값의 복사 없이 원본 인자에 접근 할수 있어여하 한다" 라고 말한 것이다.