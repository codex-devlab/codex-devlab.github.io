---
title: "강제 캐스팅에 의한 1byte 단위 접근 방법"
date: 2018-06-15T04:22:12+06:00
menu:
  sidebar:
    name: 강제 캐스팅에 의한 1byte 단위 접근법
    identifier: 1-byte-unit-access-by-forced-casting
    parent: sub-programming-language
    weight: 30
tags:
- Study
- C
- Theory
- Embeded
---

## [1Byte access](https://github.com/ehdwn1991/Embeded.study/blob/master/C_programing/0615/address_swap.c)

`강제 캐스팅에 의한 1byte 단위 접근 방법`

```c
다음과 같이 출력되도록 코드를 짜시오.
temp : 0x12345678
temp : 0x78563412
```

```c
// 강제 캐스팅에 의한 1byte 접근법
#include <stdio.h>

int main(){
	char *s;
	char swap_char;
	int temp=0x12345678;
	s=(char*)&temp; //4byte의 값을 1byte씩 접근
// a=(char)&temp; 변수 자료형의 형변환
	printf("temp : 0x%x\n",temp );
	swap_char=*s;
	*s=*(s+3);
	*(s+3)=swap_char;

	swap_char=*(s+1);
	*(s+1)=*(s+2);
	*(s+2)=swap_char;

	printf("temp : 0x%x\n",temp );
}
```

이런 방법론은 Endian 문제에 적용시킬수 있다. Little Endian 과 Big Endian 과의 데이터 불일치가  

발생할때 1byte접급으로 값을 뒤집어 주면 된다.

## [Pointer swapping within address](https://github.com/ehdwn1991/Embeded.study/blob/master/C_programing/0618/pointer_address_swap.c)

`2중 포인터를 사용한 포인터 교환`
```c
int a=5,b=8;
int *q=&a,*p=&b;
...
swap(&q,&p);
printf("a:%d b:%d\n",*q,*p);
printf("a:%d b:%d \n",a,b );
//출력
*p:8 *q:5
 a:5  b:8
```

원래 대로라면 q와 p는 각각 a와 b의 값을 pointer addres로 가리키고 있다.  

기존에 하던 swap의 함수를 사용하면 q와 p가 가리키고 있는 a와 b의 값이 서로 맞바뀌어야한다.  

하지만 swap함수 호출수 a와 b의 값은 그대로 지만, q와 p의 값은 바뀌었다.  

이유가 뭘까?

아마 각자의 뇌피셜로는 q와 p가 a와 b의 주소값을 담고 있었지만,  

swap함수를 지나면서 q와 p가 서로가 갖고 있는 주소 값을 맞바꾸면 된다.

물론 그렇게 하는게 맞다. 좀더 자세하게 들여다 보자.

```c
#include <stdio.h>
void best_reverse();
void reverse();
int main(){
int temp=5;
	int val=8;
	int *pt=&temp;
	int *pv=&val;
	printf("before swap => temp(%p) has : %d val(%p) has : %d\n",&temp,temp,&val,val );
	printf("before  swap => *pt(%p)->[0x%x] has : %d *pv(%p)->[0x%x] has : %d\n",&pt,pt,*pt,&pv,pv,*pv );
    //reverse(&pt,&pv);
	best_reverse(&pt,&pv);
	printf("\n================================\n\n");
	printf("after swap => temp(%p) has : %d val(%p) has : %d\n",&temp,temp,&val,val );
	printf("after  swap => *pt(%p)->[0x%x] has : %d *pv(%p)->[0x%x] has : %d\n",&pt,pt,*pt,&pv,pv,*pv );

}
//두개의 차이점 공부!
void reverse(int *a,int *b){
    // 이랗게 해도 돌아가긴 하는데 사실상 부적절한 부분이다.
	// 왜냐하면 현재 주소를 받아오지만 reverse 함수에서 temp 는
	// 정수형 변수이고  만약 주소 값이 정수형 범위를 초과하는 주소 값이라면 
	// 오류가 발생할수도 있다.
	int temp;
	temp=*a;
	*a=*b;
	*b=temp;

}
void best_reverse(int **a,int **b){
	int *temp=*a;
	printf("add_pt:%p add_pv:%p\n",*a,*b );
	printf("add_pt:%p add_pv:%p\n",a,b );
	printf("add_pt:%p add_pv:%p\n",&a,&b );
	*a=*b;
	*b=temp;

}
```





## [Substraction of max and min](https://github.com/ehdwn1991/Embeded.study/blob/master/C_programing/0615/applied_pro.c)

`임의의 무작위 배열값에서 최대값과 최소값의 차를 구하시오`

배열의 값은 임의로 무작위로 들어있다.  

여기에서 최대값과 최소값의 차를 구하려면, Sort알고리즘을 통해서 오름차순으로 정렬하면 편하다.  

해당 문제에서는 buble sort를 사용했다.

```c
// 최대값 최소값의 차 
#include <stdio.h>

int MaxMin_Arr();
void Input_Arr();
void buble();
int main(void)
{
	int ArrValue[5];
	int result = 0;
  	int len=sizeof(ArrValue)/sizeof(int);
	Input_Arr(ArrValue);
	result = MaxMin_Arr(ArrValue,len);

	printf("최대값 과 최소값의 차이 : %d\n\n", result);

	return 0;
}
void buble(int *a,int size){
	int temp=0;
	for (int i = 0; i < size; ++i)
	{
		for (int j = size-1; j >i; --j)
		{
			if(a[j-1]>a[j]){
				temp=a[j-1];
				a[j-1]=a[j];
				a[j]=temp;
			}
		}
	}
}
int MaxMin_Arr(int* pA,int size)
{
	buble(pA,size);
	return pA[size-1]-pA[0];
}
void Input_Arr(int* pV)
{
	int N;
	scanf("%d",&N);
	for (int i = 0; i < N; ++i)
	{
		scanf("%d",&pV[i]);
	}
}
```



## [Find specific alphabet](https://github.com/ehdwn1991/Embeded.study/blob/master/C_programing/0615/applied_pro2.c)

`배열에서 특정 문자 찾기`

```c
//특정 문자 찾기
#include <stdio.h>
int find_ch(char* pS);
int main(void)
{
	char buf[30] = "Hello Embedded";
	int num = 0;
	num = find_ch( buf );
	printf(" d 문자의 개수 : %d\n", num);
	return 0;
}
int find_ch(char* pS)
{
	int count=0;
     while(*pS++!='\0'){
     	if(*pS=='d')
     		count++;
     }
     return count;
}
```

해당 문제는 d의 위치를 찾는 것이다.



## [Implementation of Strcpy](https://github.com/ehdwn1991/Embeded.study/blob/master/C_programing/0615/applied_pro3.c)

`Strcpy구현`

```c
// strcpy 구현
#include <stdio.h>
void my_strcpy(char* pS, char* pD );
int main(void)
{
	char src[100] = "Hello Embedded";
	char dest[100];
	my_strcpy( src, dest);
	printf ("dest: %s\n\n",dest );  // Hello Embedded 출력
	return 0;
}
void my_strcpy(char* pS, char* pD )
{
	while(*pS!='\0'){
		*pD=*pS;
		pD++;
		pS++;
	}
}
```



## [Implementation of Strcat]()
`Strcat 구현`
```c
// 두번째 문자열을 첫번째 배열 뒤에 붙이는 함수는 구현 하시요.
// 첫번째 문자열과 두번째 문자열 구별하기 위해 '#' 문자를 사이에 추가
#include <stdio.h>

void my_strcat(char* pF, char* pS);

int main(void)
{
	char Fir_str[100] = "embedded";
	char Sec_str[30] = " Programmer";
	my_strcat(Fir_str, Sec_str);
	printf("Fir_str : %s\n\n", Fir_str);    // embedded # Programmer 출력
	return 0;
}
void my_strcat(char* pF, char* pS)
{
	int idx=0,count=0;
	while(pF[idx++]!='\0');
	while(pS[count]!='\0'){
		// printf("ps: %c\n",pS[count] );
		pF[idx-1+count]=pS[count];
		count++;
	}
}
```



## [Implementation of Stack](https://github.com/ehdwn1991/Embeded.study/blob/master/C_programing/0615/stack.c)

`Stack 구현`

Push, Pop, Isempty 만 구현

```c
#include <stdio.h>
#include <stdlib.h>
#define expand 5
void Push(int* pStk, int* pT);
int Pop(int* pStk, int* pT);
void DataDisplay(int *pStk, int* pT);
void clearbuff();
void isEmpty();
int expand_stack();
int main()
{
	// int Stack[5];
	int top = 0;
	int nMenu = 0;
	int delVal = 0;
	int max_element=0;
	int *Stack=(int*)malloc(sizeof(int)*expand);
	max_element=expand;
	while (1)
	{
		printf("============== 스택 구조 삽입/삭제 프로그램 ==============\n");
		printf("1. 데이터 삽입    2. 데이터 삭제   3. isEmpty?     4. 종료\n");
		printf("메뉴 선택 : ");
		scanf("%d", &nMenu);
		clearbuff();
		switch (nMenu)
		{
			case 1:
			if (top == max_element)
			{
				printf("스택 메모리 Overflow !!\n\n");
				DataDisplay(Stack, &top);
				printf("Memory increse %d byte\n\n",expand_stack(Stack,top,&max_element));
				break;
			}
			Push(Stack, &top);
			DataDisplay(Stack, &top);
			break;
			case 2:
			if (top == 0)
			{
				printf("스택 메모리 Underflow !!\n\n");
				DataDisplay(Stack, &top);
				break;
			}
			delVal = Pop(Stack, &top);
			printf("삭제된 데이터 : %d\n\n", delVal);
			DataDisplay(Stack, &top);
			break;
			case 3:
			isEmpty();
			break;
			case 4:
			printf("프로그램 종료\n");
			break;
		}
		if (nMenu == 3) break;
	}
	return 0;
}
int expand_stack(int *before_stack,int pT,int *limit_elements){
	int resize=0;
	printf("\nresize:%d\n",pT);
	before_stack=(int*)realloc(before_stack,sizeof(int)*pT);
	*limit_elements+=(sizeof(int)*pT)+pT;
	return (sizeof(int)*pT)+pT;
}
void isEmpty(int *pStk,int *top){
	if(pStk[0]=='\0'){
		printf("Stack is empty\n");
	}
	else{
		printf("Stack is not empty\n");
		printf("Top elements is %d\n",*(top-1) );
	}
}
void Push(int* pStk, int* pT)
{	int input=0;
	scanf("%d",&input);
	if(*pT==0){
		pStk[*pT]=input;
		*pT+=1;
	}
	else{
		pStk[*pT]=input;
		*pT+=1;
	}
	clearbuff();
}
int Pop(int* pStk, int* pT)
{	int out=0;
	out=pStk[*pT-1];
	pStk[*pT-1]='\0';
	*pT-=1;
	return out;
}
void DataDisplay(int *pStk, int* pT)
{
	for (int i = 0; i < *pT; ++i)
	{
		if(i==0){
			printf("bottom=> %d ",pStk[i] );
		}
		else{
			printf("| %d ",pStk[i]);
		}
	if(i==*pT-1)printf("<=top");
	}
	printf("\nElements : %d\n",*pT);

}
void clearbuff(){
	while(getchar()!=10);
}
```

