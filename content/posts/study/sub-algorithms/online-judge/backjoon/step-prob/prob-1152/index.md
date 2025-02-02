---
title: Problem.1152
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.1152
    identifier: backjoon-1152
    parent: backjoon
    weight: 50
tags:
- C
- String
- Backjoon
- Online-Judge
---


> [백준 단계별 문제집 문자열](https://www.acmicpc.net/step/7)  
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_6/1152.c)


## [Problem.1152](https://www.acmicpc.net/problem/1152)
`1152번[단어의 개수]`
```c
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int main(){

	int count=0,is_word=0;
	//is_word=0 =>until not using any word
	//is_word=1 =>wherever used any word before using space
	char input;
//공백은 연속으로 나오는 일이 없으니 공백만 잘 체크해 주면 된다.
	while((input=getchar())!=EOF){
		if(input==10){
			if(is_word==1)
				count++;
			break;
		}
		if(input>32){
			is_word=1;
		}
		else{
			if(input==32&&is_word==0){//is space
			}
			else if(input==32&&is_word==1){
				count++;
				is_word=0;
			}
		}
	}
	printf("%d\n",count );
}
```
>문제에서 헷갈리는 부문이 있다.
>1.시작이 공백
>2.끝이 공백
>두가지 경우를 어떻게 처리할것인가가 좀 헷갈렸다.
>[시작이 공백]
>		시작이 공백이고 아직 단어가 한번도 안나온 경우
>		시작이 공백이지만 이미 단어가 한번 나온경우
>[끝이 공백]
>		마지막 문자가 Newline이고 is_word가 1이라면 이전에 글자가 있었던것  
