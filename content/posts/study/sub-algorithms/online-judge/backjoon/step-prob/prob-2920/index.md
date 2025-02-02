---
title: Problem.2920
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.2920
    identifier: backjoon-2920
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---


> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_6/2920.c)



## [Problem.2920](https://www.acmicpc.net/problem/2920)
`2920번[음계]`
```c
#include <stdio.h>
int main(){
	int temp[8]={0,};
	int state[8]={0,};
	int now_state;
	// 0=ascending 1=descending 2=mix
	for(int i=0;i<8;i++){
	scanf("%d",&temp[i]);
	}
	now_state=temp[1]-temp[0];
	for(int j=0;j<7;j++){
		if(now_state==1&&now_state==(temp[j+1]-temp[j]))
		//오름차순
			continue;
		else if(now_state<0&&now_state==(temp[j+1]-temp[j]))
		//내림차순
			continue;
		else{
			now_state=2;
			//등차 수열을 이루지 못해서 Mix의 상태임.
		break;
		}
	}	
	if(now_state==1)
		printf("ascending\n");
	else if(now_state<0)
		printf("descending\n");
	else
		printf("mixed\n");
}
```
>시작이 1 혹은 8 둘중하나로 시작 하면 오름차순 이거나 내림차순 일것이다.
>즉 하나의 수열로 봤을때 등차 수열이 되야한다는것.
>등차 수열을 이루지 못하다면 Mix 인것이다.

