---
title: Problem.15552
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.15552
    identifier: backjoon-15552
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---

 
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_3/15552.c)

## [Problem.15552](https://www.acmicpc.net/problem/15552)
`15552번[열개씩 끊어서 출력하기]`
문제 : 각 테스트케이스마다 A+B를 한 줄에 하나씩 순서대로 출력한다.(입력 A,B는 1000이하 케이스 T는 최대 1,000,000이다.)  

```c
#include <stdio.h>

int main(){
	int N;
	int a,b;
	scanf("%d",&N);
	for (int i = 0; i < N; ++i)
	{
		scanf("%d %d",&a,&b);
		printf("%d\n",a+b);
	}
}
```
