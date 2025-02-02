---
title: Problem.1065
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.1065
    identifier: backjoon-1065
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---


[모든 내용은 Git Hub에도 있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_5/1065.c)


## [Problem.1065](https://www.acmicpc.net/problem/1065)

`1065번 문제(성공)-한수`
각 자리수가 등차 수열을 이루면 한수로 취급한다.
예를 들어 보자 99는 한수 인가? 9와 9는 공차 0으로 한수이다.
그렇다면 100은 어떤가? 한수 일리가 없다. 즉 99이하는 전부 한수가 된다.
하지만 100부터는 각 자리수에 따라 달라질수도 있다.
100이후 첫 한수가 되는것은 111일것이다.


```c
#include <stdio.h>

int main(){
	int N;
	int place_value[3]={'\0',};
	int Hansu=0;
	scanf("%d",&N);

	for (int i = 1; i <= N; ++i)
	{
		if(i<100){
			Hansu++;
			// printf("11's : %d  \n",i );
		}
		else if(i==1000){
			break;
		}
		else if(99<i){
			place_value[0]= i/100;
			place_value[1]=(i-place_value[0]*100)/10;
			place_value[2]=((i-place_value[0]*100)-(place_value[1]*10));
			if(place_value[0]-place_value[1]==place_value[1]-place_value[2]){
				Hansu++;
			}
			else{
			// printf("two's com : %d  0:%d 1:%d 2:%d\n",i ,place_value[0],place_value[1],place_value[2]);
			printf("%d\n",i );
			}



		}
	
	}
	printf("%d\n",Hansu );

}
```


