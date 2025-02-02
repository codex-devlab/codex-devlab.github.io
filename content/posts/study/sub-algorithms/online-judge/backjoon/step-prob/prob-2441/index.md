---
title: Problem.2441
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.2441
    identifier: backjoon-2441
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---

 
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_3/2441.c)

## [Problem.2441](https://www.acmicpc.net/problem/2441)
`2441번 [별찍기4]`
문제  : 다음과 같이 만들어지도록 출력

```c
*****
 ****
  ***
   **
    *
```

```c
#include <stdio.h>

int main(){
	int N,space,asteric=0;
	scanf("%d",&N);
	space=N;
	for (int i = 0;i<N ; ++i)
	{	
		for (int k = 0; k <i; ++k)
		{
			printf(" ");//asteric
		}
		for (int j = 0; j < space-i; ++j)
		{
			printf("*");//space
		}
		printf("\n");
	}


}
```

풀이 :  N줄 까지 역순 우측 정렬로 출력 하는 문제. 2439번에서 for문 순서만 바꿔주면 된다.
