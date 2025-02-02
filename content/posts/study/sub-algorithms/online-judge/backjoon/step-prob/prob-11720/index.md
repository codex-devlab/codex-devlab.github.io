---
title: Problem.11720
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.11720
    identifier: backjoon-11720
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---

 
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_3/11720.c)



## [Problem.11720](https://www.acmicpc.net/problem/11720)
`숫자의 합`
문제 : N개의 숫자가 공백 없이 쓰여있다. 이 숫자를 모두 합해서 출력하는 프로그램을 작성하시오.  

```c
#include <stdio.h>
#include <stdlib.h>
int main(){
	char input;
	int result=0;
	int N,buf;
	scanf("%d\n",&N);
	for (int i = 0; i < N; ++i)
	{
		// input=getchar();
		// result+=atoi(&input);
			result+=(getc(stdin))-48;
	}
	//이렇게 해도 똑같은데 그럼 N을 쓸일이 없고 아무래도
    //atoi함수를 써서 틀린거 같음 노이해
	// while((input=getchar())!=10){
	// 	result+=atoi(&input);
	// }
	printf("%d\n",result );
}
```
풀이 : 키보드로 부터 입력 받은 수(decimal)를 result에 계속 더함  

