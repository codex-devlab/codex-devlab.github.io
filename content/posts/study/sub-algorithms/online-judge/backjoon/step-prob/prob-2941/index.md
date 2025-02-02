---
title: Problem.2941
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.2941
    identifier: backjoon-2941
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---


> [백준 단계별 문제집 심화1](https://www.acmicpc.net/step/52)  
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_7/2941.c)


##[Problem.2941](https://www.acmicpc.net/problem/2941)
`크로아티아 알파벳`
```c
#include <stdio.h>
#include <string.h>
int main(){
	char buf[101]={'\0',};
	int croatia=0;
	scanf("%s",buf);
	for(int i=0;i<strlen(buf);i++){
		if(buf[i]=='c'&&(buf[i+1]=='='||buf[i+1]=='-')){
			croatia++;
			i+=1;
		}
		else if(buf[i]=='d'){
			if(buf[i+1]=='z'&&buf[i+2]=='='){
				croatia++;
				i+=2;
			}
			else if(buf[i+1]=='-'){
				croatia++;
				i+=1;
			}
			else{
			croatia++;
			}
		}
		else if(buf[i]=='l'&&buf[i+1]=='j'){
			croatia++;
			i+=1;
		}		
		else if(buf[i]=='n'&&buf[i+1]=='j'){
			croatia++;
			i+=1;
		}		
		else if(buf[i]=='s'&&buf[i+1]==61){
			croatia++;
			i+=1;
		}
		else if(buf[i]=='z'&&buf[i+1]=='='){
			croatia++;
			i+=1;
		}
		else{
			croatia++;
		}
	}
printf("%d\n",croatia);
}
```
>이것도 조건에 맞춘 노가다 인듯 싶다.
