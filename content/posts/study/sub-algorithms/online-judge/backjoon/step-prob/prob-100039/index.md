---
title: Problem.100039
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.100039
    identifier: backjoon-100039
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---


> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_6/100039.c)


## [Problem.100039](https://www.acmicpc.net/problem/100039)
`평균점수`
```c
#include <stdio.h>
int main(){
	int a;
	int temp[5]={0,};
	int total=0;
	for(int i=0;i<5;i++){
		scanf("%d",&temp[i]);
		if(temp[i]<40)
			temp[i]=40;
		total+=temp[i];
	}
	printf("%d\n",total/5);
}
```