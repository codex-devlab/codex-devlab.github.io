---
title: Problem.1157
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.1157
    identifier: backjoon-1157
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---


> [백준 단계별 문제집 레벨 3](https://www.acmicpc.net/step/3)  
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_7/1157.c)


##[Problem.1157](https://www.acmicpc.net/problem/1157)
`단어 공부`
```c
#include <stdio.h>
#include <string.h>
int main(){
	int alpha[26]={0,};
//	정수형 배열을 쓰는 이유는 단어의 길이가 1000000이기 때문에 반복된
//	알파벳의 횟수가 127번을 넘어가면 CHAR형의 범위를 넘어버린다.
	char temp;
	int Max_comp=0;
	int comp2=0;
	int comp1=0;
    //각 단어가 들어왔을때 대소문자 상관없이 각 문자 마다 카운트 한다.
	while((temp=getchar())!=10){
		if(temp>64&&temp<91){
		//대문자 일때
			alpha[temp-65]+=1;
		}
		else{
	//		소문자 일때
			alpha[temp-97]+=1;
		}
	}
	//가장 많이 사용되 문자 찾는과정
	for(int i=0;i<26;i++){
		if(alpha[i]!=0){
			Max_comp=(Max_comp>alpha[i]?Max_comp:alpha[i]);
	}
	}
	
	for(int j=0;j<26;j++){
		if(Max_comp==alpha[j]){
			comp1=j;
			comp2++;//가장 많이 사용된 문자의 갯수를 저장	
		}
	}
	
	if(comp2>1){
	printf("?\n");
	//가장 많이 사용한 문자가 2개이상 일때는 ?를 출력
	}
	else
	printf("%c\n",comp1+65);
	//가장 많이 사용한 문자가 2개 미만일때는 해당 문자 출력
}
```
>가장 많이 사용된 문자의 갯수를 문자별로 배열에 저장하고,
>가장많이 사용된 문자를 찾아 다시 비교해 주면된다.
>비교 하는 과정에서 가장큰 문자는 1번만 나와야하고 2번 이상 나온다면 "?"를 출력해주어야 한다.  


