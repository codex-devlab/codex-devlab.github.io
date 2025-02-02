---
title: Problem.2257
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.2257
    identifier: backjoon-2257
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---

 
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_6/2257.c)


## [Problem.2257](https://www.acmicpc.net/problem/2577)
`2257번[숫자의 개수]`
```c
#include <stdio.h>
int main(){
	int a,b,c,multi;
	int count[10]={0,};
	scanf("%d",&a);
	scanf("%d",&b);
	scanf("%d",&c);
	multi=a*b*c;
	while(multi>0){
		count[multi%10]+=1;
		multi/=10;
	}
	for (int i = 0; i < 10; ++i)
	{
		printf("%d\n",count[i]);
	}
}
```

