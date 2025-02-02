---
title: Problem.1546
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.1546
    identifier: backjoon-1546
    parent: backjoon
    weight: 50
tags:
- C
- Level 4
- Array
- Backjoon
- Online-Judge
---


> [백준 단계별 문제집 레벨 4](https://www.acmicpc.net/step/6)  
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_4/1546.c)


## [Problem.1546](https://www.acmicpc.net/problem/1546)
`1546번[평균]`
```c
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int main(){

	int N;
	float grade[1001];
	int i=0;
	int temp_grade,count=0;
	int max_grade_pointer=0,max_grade;;
	int sum=0;
	float avg=0;
	scanf("%d\n",&N);
	for (int i = 0; i < N; ++i)
	{
		scanf("%d",&temp_grade);
		grade[i]=temp_grade;
		if(grade[max_grade_pointer]>=temp_grade){
			continue;
		}
		else{
			max_grade_pointer=i;
			//printf("Max : %d\n",max_grade_pointer );
		}
	}
	max_grade=grade[max_grade_pointer];
	for (i=0; i < N; ++i)
	{
			grade[i]=(float)((int)((grade[i]/max_grade*100)*1000+5))/1000;
		//문제에서 새로 바뀐 점수도 소수점 2번째 자리 까지 반올림 하라는 문장은 없지만 그렇게 해줘야댐
		avg+=grade[i];
	}
	printf("%.2f\n",avg/N);
```
>알고리즘은 별거 없지만, 자료를 잘 다뤄줘야 한다. 
>최대 값에 맞춰서 새로운 점수를 맞출때에도 소수 2번째 자리 까지 반올림 해줘야 한다.
>그리고 마지막 평균을 구해줄때에도 소수 2번째 자리 까지 반올림 해줘야함.