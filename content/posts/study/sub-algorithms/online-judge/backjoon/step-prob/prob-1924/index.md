---
title: Problem.1924
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.1924
    identifier: backjoon-1924
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---

 
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_3/1924.c)



## [Problem.1924](https://www.acmicpc.net/problem/1924)
`1924번 [2007]`
문제  : 오늘은 2007년 1월 1일 월요일이다. 그렇다면 2007년 x월 y일은 무슨 요일일까? 이를 알아내는 프로그램을 작성하시오.

```c
#include <stdio.h>

int main(){
	char *day_of_week[7]={"SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"};
	//2007year 1month 1day is monday
	// SUN, MON, TUE, WED, THU, FRI, SAT
	int month_of_day[12]={31,28,31,30,31,30,31,31,30,31,30,31};
	//1, 3, 5, 7, 8, 10, 12월은 31일까지, 4, 6, 9, 11월은 30일까지, 2월은 28일까
	int month=0,day=0,now_of_day=0;
	// printf("\n");
	scanf("%d %d",&month,&day);
	for(int i=0;i<month-1;i++){
			now_of_day+=month_of_day[i];
	}
	now_of_day+=day;
	printf("%s\n",*(day_of_week+(now_of_day%7)));
}
```

풀이 : 월 과 일이 입력으로 주어지고, 현재 1월1일부터 몇일이 지났는지 now_of_day에 저장 후 요일을 계산  

