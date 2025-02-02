---
title: Problem.4673
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.4673
    identifier: backjoon-4673
    parent: backjoon
    weight: 50
tags:
- C
- Backjoon
- Online-Judge
---

[모든 내용은 Git Hub에도 있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_5/4673.c)


## [Problem.4673](https://www.acmicpc.net/problem/4673)
`4673번 문제(성공)`
>셀프넘버  
>[Wiki 참고](https://en.wikipedia.org/wiki/Self_number)

```c
#include <stdio.h>
int generate(int n_times);
int main() {

	int check_generator[10000] = { 0, };
	int generate_state=0;
	for (int i = 1; i <= 10000; i++) {
		generate_state = generate(i);
		

		if (check_generator[generate_state-1] == 0) {
			check_generator[generate_state-1] = 1;
		}
		else { continue; }

	}

	for (int q = 1; q<=10000; q++) {
		if (check_generator[q-1] == 0) {
			printf("%d\n", (q));
		}
	}
}

int generate(int n_times) {
	int now_decimal = n_times, sum_of_generator=0;
	int digits = n_times, run = 1;
	while (digits >= 1) {
		digits /= 10;

		run*=10;
	}
	while (run>=1) {
		sum_of_generator += now_decimal / run;
		now_decimal -= (now_decimal / run)*run;
		run /= 10;
	}
	return sum_of_generator += n_times;
}

```
