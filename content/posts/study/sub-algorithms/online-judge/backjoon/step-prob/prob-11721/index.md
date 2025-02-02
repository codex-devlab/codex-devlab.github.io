---
title: Problem.11721
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.11721
    identifier: backjoon-11721
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---

 
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_3/11721.c)


## [Problem.11721](https://www.acmicpc.net/problem/11721)
`11721번[열개씩 끊어서 출력하기]`
문제 : 알파벳 소문자와 대문자로만 이루어진 길이가 N인 단어가 주어진다.   
한 줄에 10글자씩 끊어서 출력하는 프로그램을 작성하시오.  

```c
#include <stdio.h>
#include <string.h>
int main(){
	int N;
	char buf[1001];
	fgets(buf,sizeof(buf),stdin);
	for (int i = 1; i < strlen(buf); ++i)
	{
		printf("%c",buf[i-1] );
		
		if(i%10==0)
			printf("\n");
	}
}
```
풀이 : fgets으로 한줄을 입력 받고 buf에서 10글자씩 출력 해준후 개행(\n).   
