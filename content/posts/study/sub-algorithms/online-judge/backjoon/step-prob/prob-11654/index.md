---
title: Problem.11654
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.11654
    identifier: backjoon-11654
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---


> [백준 단계별 문제집 레벨 3](https://www.acmicpc.net/step/3)  
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_7/11654.c)


## Level7


## [Problem.11654](https://www.acmicpc.net/problem/11654)
`아스키 코드`
```c
#include <stdio.h>
int main(){
	char a;
	while((a=getchar())!=EOF){
		if(a!=10)
			printf("%d\n",a);
	}
}
```