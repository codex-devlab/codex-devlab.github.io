---
title: Problem.10871
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.10871
    identifier: backjoon-10871
    parent: backjoon
    weight: 50
tags:
- C
- Level 4
- Array
---


> [백준 단계별 문제집 레벨 4](https://www.acmicpc.net/step/6)  
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_17/10871.c)


## [Problem.10871](https://www.acmicpc.net/problem/10871)
`10871번[X보다 작은수]`
```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(){
	int input[10000];
	int N=0,X=0,insert_num=0;
	scanf("%d %d\n",&N,&X);
	for(int i=0;i<N;i++){
		scanf(" %d",&insert_num);  //scanf의 심오한 의미 공부!!!
		input[i]=insert_num;
	}
	for (int i = 0; i < N; ++i)
	{
		if(input[i]<X)
		printf("%d ",input[i] );
	}
}
```
>알고리즘은 별게 없다. 근데 입력 부분에서 getc를 썻으면 조금 편했을지 모르겠지만
>일단 시작을 scanf로 하기로했으니, 공백을 무시하면서 숫자를 입력받을수 있어야 했다.
>덕분에 scanf(" %d")의 심오한 의미를 공부할수 있었다.

>먼저 IBM에서 제공하는 Scanf의 정의먼저 보겠습니다.
>
>공백 문자로,[isspace()함수](https://www.ibm.com/support/knowledgecenter/ko/ssw_ibm_i_73/rtref/isalnum.htm?view=kc#isalnum)(줄 바꾸기 문자와 공백과 같은)에서 지정됩니다.
>공백 문자로scanf()함수는 공백이 아닌 다음 문자까지 입력의 모든 연속 공백 문자를 읽지만 저장하지 않습니다. 
>format-string의 한 공백 문자는 입력에서 공백 문자의 조합과 일치합니다.
>
>퍼센트 기호 문자(%)를 제외하고, 공백이 아닌 문자입니다.
>공백이 아닌 문자로scanf()함수는 일치하는 공백이 아닌 문자를 읽지만 저장하지 않습니다.
>stdin의 다음 문자가 일치하지 않는 경우,scanf()함수가 종료합니다.


>다음 예제를 확인 하면 확실하게 이해가 갈것이다.

```c
#include <stdio.h>

int main(){
	int a,b;
	scanf("%d ",&a);
	printf("%d\n",a);
	scanf("%d ",&b);
	printf("%d\n",b);
	}
```
```shell
$./a.out
1
1
2
2
```
>우리가 1을 입력후 엔터를 치면 1이 출력되고
>그다음 2를 입력하면 2가 출력 될것이라고 예상할것이다.
```shell
$./a.out
1
2
1
q
2
```
>하지만 1을 입력후 2를 입력해야 1이 출력되고 q를 입력하자 2가 출력된다 왜일까?
>scanf("%d ",&a) 를 해석해 보자 %d뒤에 공백이 있는데,
>숫자, 1자 이상의 공백문자, 공백문자가 아닌 문자값이 들어오기를 기다립니다.
>그렇다면 1을 입력후에는 버퍼안에 1이 들어가있고
>그다음 공백 문자 이외의 문자를 기다립니다.
>물론 우리는 엔터를 통해 '\n'을 입력했지만 New line은 문자로 할당되지 않습니다.
>그리고 다음 기대 값인 2를 입력 했을때 비로소 공백이 아닌 문자가 들어오게 된것이죠.
>그래서 버퍼에있던 1을 출력해 주고 현재 버퍼엔 2가 남아있게 됩니다.
>그리고 아무 문자를 입력하고 나면 공백이아닌 문자가 들어왔기 때문에
>2가 출력되게 되는것입니다.
>그리고 프로그램이 끝나기 전까지는 버퍼에 마지막 입력했던 문자가 들어있겠지요.
[IBM Scanf 정의](https://www.ibm.com/support/knowledgecenter/ko/ssw_ibm_i_73/rtref/scanf.htm)
[여기 참고](http://electro-don.tistory.com/entry/scanf-n-%EA%B4%80%EB%A0%A8)




[모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_17/10871.c)