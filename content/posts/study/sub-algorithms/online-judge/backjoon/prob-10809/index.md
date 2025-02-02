---
title: Problem.10809
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.10809
    identifier: backjoon-10809
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---


> [백준 단계별 문제집 레벨 3](https://www.acmicpc.net/step/3)  
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_7/10809.c)



## [Problem.10809](https://www.acmicpc.net/problem/10809)
`10809번알파벳 찾기`
```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(){
	char comp_alpha[26]="abcdefghijklmnopqrstuvwxyz";
	int comp_location[26]={0,};
	char buf[110]={'\0',};
	for(int i=0;i<26;i++){
	comp_location[i]=-1;
	}
	fgets(buf,sizeof(buf),stdin);
    //a~z까지 입력된단어에서의 처음 위치를 찾는다
	for(int i=0;i<26;i++){
		for(int j=0;j<strlen(buf);j++){
			if(buf[j]==comp_alpha[i]){
				comp_location[i]=j;
				break;
			}
		}
	}
for(int i=0;i<26;i++){
printf("%d ",comp_location[i]);
}
puts("");
}

```

>알파벳은 26개이다 각 단어에서 알파벳이 처음 등장 하는 위치를 다른 배열에 저장한다.
>
>반복문에서 처음 위치를 찾으면 break 되기 때문에
>
>중복이 되서 그다음 위치가 저장될일이 없다.
