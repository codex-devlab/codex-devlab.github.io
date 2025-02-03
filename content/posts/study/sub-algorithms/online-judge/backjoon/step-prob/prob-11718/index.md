---
title: Problem.11718
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.11718
    identifier: backjoon-11718
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---

 
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_1/11718.c)


## [Problem.11718](https://www.acmicpc.net/problem/11718)
`그대로 출력하기1`
문제 : 입력 받은 대로 출력하는 프로그램을 작성하시오.  

```c
#include <stdio.h>

int main(int argc,char **argv){
	char through_out;
	while((through_out=getchar())!=EOF){
		putchar(through_out);
	}	
}

```

풀이 : 여러가지 함수가 있지만 개행(\n)문자가 들어와도 입력이 끝나면 안된다.  
때문에 getchar함수를 통해 개행(\n)문자 까지 출력하면 입력 그대로 출력 완료  

