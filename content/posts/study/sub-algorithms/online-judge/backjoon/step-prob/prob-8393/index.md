---
title: Problem.8393
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.8393
    identifier: backjoon-8393
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---

 
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_3/8393.c)


## [Problem.8393](https://www.acmicpc.net/problem/8393)
`8393번[합]`
문제  : n이 주어졌을 때, 1부터 n까지 합을 구하는 프로그램을 작성하시오.
```c
#include <stdio.h>

int main(){
    int N,sum=0;
    scanf("%d",&N);
        for(int i=1;i<=N;i++)
            sum+=i;
    printf("%d\n",sum);
    
}
```
