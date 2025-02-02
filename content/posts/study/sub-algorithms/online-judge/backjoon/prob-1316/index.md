---
title: Problem.1316
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.1316
    identifier: backjoon-1316
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---


> [백준 단계별 문제집 심화1](https://www.acmicpc.net/step/52)  
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_7/1316.c)



##[Problem.1316](https://www.acmicpc.net/problem/1316)
`그룹 단어 체커`
```c
#include <stdio.h>
#include <string.h>
int checker();
int main(){
	int N;
	char buf[101]={'\0',};
	int result=0;
	scanf("%d",&N);
	for(int i=0;i<N;i++){
		scanf("%s",buf);
		result+=checker(buf);
	}
printf("%d\n",result);



} 

int checker(char *q){
	char alpha[101]={'\0'};
	int duplicate_count=0;
	for(int i=0;i<strlen(q);i++){
		if(alpha[duplicate_count]==0&&alpha[duplicate_count-1]!=(*(q+i)))		{//알파벳 배열에 연속된 같은 문자의 중복을 피하고 저장 
			alpha[duplicate_count]=(*(q+i));
			duplicate_count++;
		}
	}

	for(int j=0;j<strlen(alpha);j++){
		for(int k=j+1;k<strlen(alpha);k++){
			if(alpha[j]==alpha[k]){
			//j번째의 문자가 j+1번째부터 배열의 길이 까지
			//한번이라도 나오면 연속단어가 성립 안됨
				return 0;
			}
		}
	}
return 1;
}
```
>입력 받은 문장에서 단어를 체크하는 함수로 입력받은 문장의 주소 전달.
>문장에서 연속된 문자의 중복을 제거하면서 한번씩만 배열에 저장
>이후 N번째의 문자가 N+1번째부터 끝까지
>한번이라도 나온다면 연속문자가 아님.  
