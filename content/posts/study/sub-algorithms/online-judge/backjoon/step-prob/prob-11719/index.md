---
title: Problem.11719
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.11719
    identifier: backjoon-11719
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---

 
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_1/11719.c)



## [Problem.11719번](https://www.acmicpc.net/problem/11719)
`그대로 출력하기2`

문제 : 입력 받은 대로 출력하는 프로그램을 작성하시오  
단,알파벳 소문자, 대문자, 공백, 숫자로만 이루어져 있다. 각 줄은 100글자를 넘지 않으며,  
빈 줄이 주어질 수도 있고, 각 줄의 앞 뒤에 공백이 있을 수도 있다.  

```c
#include <stdio.h>
int main(int argc,char **argv){
	char through_out;
	while((through_out=getchar())!=EOF){
		putchar(through_out);
	}	
}
```

풀이 : [11718번](https://www.acmicpc.net/problem/11718)과 동일.  
입력시 한 글자씩 입력을 받고 받은 그대로 출력하기 때문에 공백, 빈칸, 대 소 문자,   숫자 뭐든지 입력 그대로 출력 됨.


