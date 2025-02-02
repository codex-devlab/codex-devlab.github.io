---
title: Problem.5622
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.5622
    identifier: backjoon-5622
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---


> [백준 단계별 문제집 문자열](https://www.acmicpc.net/step/7)  
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_7/5622.c)

##[Problem.5622](https://www.acmicpc.net/problem/5622)
`다이얼`
```c
#include <stdio.h>
#include <string.h>
int main(){
	char buf[16]={'\0',};
	int result=0;
	scanf("%s",buf);
	for(int i=0;i<strlen(buf);i++){
		if(buf[i]>=65&&buf[i]<=67)
			result+=3;	
		else if(buf[i]>=68&&buf[i]<=70)
			result+=4;
		else if(buf[i]>=71&&buf[i]<=73)
			result+=5;
		else if(buf[i]>=74&&buf[i]<=76)
			result+=6;
		else if(buf[i]>=77&&buf[i]<=79)
			result+=7;
		else if(buf[i]>=80&&buf[i]<=83)
			result+=8;
		else if(buf[i]>=84&&buf[i]<=86)
			result+=9;
		else	
		result+=10;
	}
	printf("%d\n",result);
}
```
>그냥 조건에 맞춘 노가다 인듯 싶다...중요한건 다이얼에서 1과 0은 입력이 없다고 보면 된다.
>2~9까지의 수만 쓰인다 생각하고 풀면됨  
