---
title: Problem.2908
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.2908
    identifier: backjoon-2908
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---


> [백준 단계별 문제집 문자열](https://www.acmicpc.net/step/7)  
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_7/2908.c)

##[Problem.2908](https://www.acmicpc.net/problem/2908)
`상수`
```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(){
	char buf[8]={0,};
	int start_num=2;
	fgets(buf,sizeof(buf),stdin);
	for(int i=3;0<i;i--){
		if(buf[i-1]>buf[i+3]&&(buf[i-1]!=buf[i+3])){
		//각 숫자의 가장 뒷부분을 비교 여기서 큰쪽이 큰수가 된다.
		//같은 수인걸 조건으로 배제해야 한다.
			start_num=2;
			break;
			}
		else{
			if(buf[i-1]<buf[i+3]&&(buf[i-1]!=buf[i+3])){
			start_num=6;
			break;
			}
		}				
	}
	//만약 두수가 111 111이라면 같은 수이므로 위의 반복문을 돌고 나서
	//start_num에는 아무 변화가 없을것이다. 그래서 초기값으로 2를 넣어줌
	for(int j=0;j<3;j++){
	printf("%c",buf[start_num-j]);
	//두 수를 비교해서 큰숫자가 판명 나면 그 숫자의 시작 번호를 받아와 거꾸로 출력
	}
	puts("");
}
```
