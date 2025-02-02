---
title: Problem.2439
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.2439
    identifier: backjoon-2439
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---

 
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_3/2439.c)


## [Problem.2439](https://www.acmicpc.net/problem/2439)
`2439번[별찍기2]`
문제  : 다음과 같이 만들어지도록 출력

```c
	*
   **
  ***
 ****
*****
```

```c
#include <stdio.h>
int main(){
	int N,space,asteric=0;
	scanf("%d",&N);
	space=N-1;
	for (int i = 0;i<N ; ++i) //N줄 까지 공백과 별을 출력해줘야함
	{	
		for (int j = 0; j < space-i; ++j)
		{//space갯수는 N-1개부터 별 의 갯수만큼 감소
			printf(" ");//space
		}
		for (int k = 0; k <= i; ++k)
		{//별의 갯수는 N번째 줄 N개가됨.
			printf("*");//asteric
		}
		printf("\n");
	}
}
```

풀이 :  N줄 까지 우측 정렬로 출력 하는 문제.


