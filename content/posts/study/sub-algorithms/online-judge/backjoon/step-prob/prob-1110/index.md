---
title: Problem.1110
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.1110
    identifier: backjoon-1110
    parent: backjoon
    weight: 50
tags:
- C
- Math
- Arithmetic
- Backjoon
- Online-Judge
---


> [백준 단계별 문제집 레벨 3](https://www.acmicpc.net/step/3)  
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_4/1110.c)


## [1110번[더하기 사이클]](https://www.acmicpc.net/problem/1110)

>처음 덧셈의 수식이 다시 한번 돌아 올때 까지의 사이클을 찾는것입니다.  
>start: 26    [2+6=8 =>(68) 6+8=14 =>(84) 8+4=12 =>(42) 4+2=6 =>(26) 2+6=8]  
>위의 예제 처럼 26이 다시 나올려면 68 -> 84-> ->42 -> 26 이렇게 4번만에원래의  
>숫자로 돌아왔습니다. 알고리즘은 비교적간단합니다.  
>처음 상태와 다음 상태 들을 비교하면서 같은 상태가 나올때 까지 사이클을 카운트 합니다.

```c
#include <stdio.h>
int circle();
int tokken_units();
int token_tens();
int main(){
	
	int N,temp_N;
	int result;
	scanf("%d",&N);

	printf("%d\n",circle(N));

}

int circle(int N){
	int count=1;
	int init_state[3];
	int next_state[3];
	int arg_first,arg_second,arg_result;
	init_state[0]=token_tens(N); //첫 시작의 10의자리 
	init_state[1]=tokken_units(N); //첫 시작의 1의자리
	init_state[2]=init_state[0]+init_state[1]; //첫 시작의 덧셈 결과
	next_state[0]=init_state[0];
	next_state[1]=init_state[1];
	next_state[2]=init_state[2];
	while(1){
		if(next_state[2]<10){
		next_state[0]=next_state[1];
		next_state[1]=next_state[2];
		next_state[2]=next_state[0]+next_state[1];
		}
		else{
		next_state[0]=next_state[1];
		next_state[1]=tokken_units(next_state[2]);
		next_state[2]=next_state[0]+next_state[1];
		}
		
			if(next_state[0]==init_state[0]&&next_state[1]==init_state[1]&&next_state[2]==init_state[2]){
			//다음 계산식이 처음과 같아지면 종료
			break;
		}
		count++;
	}
			return count;
}
int tokken_units(int N){
	int units;//units 일의 자리
	units= N-(N/10)*10;

	return units;
}
int token_tens(N){
int tens;//units 일의 자리
tens= N/10;
return tens;
}
```

