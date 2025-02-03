---
title: Problem.2839
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.2839
    identifier: backjoon-2839
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---

 
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_6/2839.c)


## [Problem.2839](https://www.acmicpc.net/problem/2839)

`2839번[사칙연산 도전하기]`  

문제 :상근이는 요즘 설탕공장에서 설탕을 배달하고 있다.  
상근이는 지금 사탕가게에 설탕을 정확하게 N킬로그램을 배달해야 한다. 설탕공장에서 만드는 설탕은 봉지에 담겨져 있다.   
봉지는 3킬로그램 봉지와 5킬로그램 봉지가 있다.  
상근이는 귀찮기 때문에, 최대한 적은 봉지를 들고 가려고 한다.  
예를 들어, 18킬로그램 설탕을 배달해야 할 때, 3킬로그램 봉지 6개를 가져가도 되지만, 5킬로그램 3개와 3킬로그램 1개를 배달하면, 더 적은 개수의 봉지를 배달할 수 있다.  
상근이가 설탕을 정확하게 N킬로그램 배달해야 할 때, 봉지 몇 개를 가져가면 되는지 그 수를 구하는 프로그램을 작성하시오.

```c
#include <stdio.h>
int how_many_pack();
int main(){

	int N=0;
	int result;
	scanf("%d",&N);
	result=how_many_pack(N);
	printf("%d\n",result);	
}
int how_many_pack(int N){

	int Calculate_N;
	int Three_kg,Five_kg;
	int num_of_pack;
	int Sum_of_multiple_Three_Five=0;
	int i=0;
		for(int i=0;i<=(N/3);i++){//3kg팩으로 만들수 있는 최대 3kg팩의 갯수
			for (int j=0;Sum_of_multiple_Three_Five<=N; ++j)
			{		Sum_of_multiple_Three_Five=(i*3)+(j*5);
				if(Sum_of_multiple_Three_Five==N){
					return i+j;
				}
			}
		Sum_of_multiple_Three_Five=0;
		}
	 return -1;
}
```
풀이 : 문제를 푸는데 있어서 중요한 케이스가 있다.

1. 최소의 팩으로 만들어야 하지만 최소의 팩에 딱 맞아 들어가지 안는 다면 -1을 출력.  

   ex.4 kg 이면 우리생각엔 5kg에 담으면 되겠지만 5kg이 되기엔 1kg이 모자라므로 -1 리턴.  

2. 18kg같은 경우 3kg 6팩 아니면 3kg 1팩  5kg 3팩 이 된다. 이런 경우 6팩 이 아닌4팩으로 이루어 져야한다는점. 

   위의 상황들을 숙지하면서 이중 반복문을 실행하는 N kg을만드는 조합을 찾으면 된다. 

