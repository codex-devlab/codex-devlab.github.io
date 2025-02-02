---
title: Problem.8958
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.8958
    identifier: backjoon-8958
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---


> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_6/8958.c)


## [Problem.8958](https://www.acmicpc.net/problem/8958)
`8958번[OX퀴즈]`
```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(){
	int now_point=0,total_point=0;
	int count=0;
	char buf[81]={'\0',};
	scanf("%d",&count);
	while(getchar()!=10);
// 입력 버퍼를 비워 주지 않으면 테스트 횟수 입력후 첫번째 케이스 문자가 입력이 안됨
// 왜냐면 처음 반복 횟수 입력후 버퍼의 상태는 N\n 이렇게 들어있음 즉 숫자와 엔터가
// 들어있는 상태임 그래서 그다음에 fgets 를 쓰려고 하면 입력이 끝나 버리는것
//그래서 두가지 방법중 하나를 써줘야됨
//1.scanf("%d ") => 공백을 하나 추가하여 
//2.while(getchar()!=10) \n 이 나올때까지 입력 버퍼를 비워줌
	for(int i=0;i<count;i++){
	fgets(buf,sizeof(buf),stdin);
	for(int j=0;j<strlen(buf);j++){
	if(buf[j]=='O'){
	++now_point;
	total_point+=now_point;
	}
	if(buf[j]=='X'){
	now_point=0;
	}	
	}
	printf("%d\n",total_point);
	total_point=0;
	now_point=0;
	memset(buf,'\0',strlen(buf));
	}
}
```
>알고리즘은 간단하다. 근데 입출력에 문제가 생겼음.
>scanf로 입력 받았을때는 버퍼의 마지막에 '\n' 이 있는 상태이고
>그다음에 바로 getchar를 쓴다면 버퍼 마지막의 '\n'을 가져 오게 된다
>그래서 첫번째 케이스의 첫 글자가 입력이 안되서,
>scanf로 입력 받고 버퍼를 비워줘야함.

