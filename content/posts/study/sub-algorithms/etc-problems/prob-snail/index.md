---
title: "Prob 달팽이 배열"
date: 2018-08-10T12:24:25+06:00
description:

menu:
  sidebar:
    name: Prob 달팽이 배열
    identifier: prob-snail-array
    parent: etc-problems
    weight: 40

tags:
- Study
- C
- Algorithms
- Array
---

달팽이 배열
===
> 윤성우의 열혈강의 C 도전프로그래밍3 -도전 2

  
  

  
```
문제 : 숫자 N을 입력받아 N by N의 배열을 다음과 같은 규칙으로 만드시오
(달팽이 모양으로 채워짐)
In 5X5
1	2	3	4	5	
16	17	18	19	6	
15	24	25	20	7	
14	23	22	21	8	
13	12	11	10	9	

In 6X6
1	2	3	4	5	6	
20	21	22	23	24	7	
19	32	33	34	25	8	
18	31	36	35	26	9	
17	30	29	28	27	10	
16	15	14	13	12	11	
```

문제 해결 전략
---
- 배열의 규칙성 찾기

  우선 배열을 채워지는 규칙에 있어서, 가로와 세로를 채우는 방법이 가장 중요하다.
  배열의 을 잘 살펴보면 가로->세로->가로->세로 순으로 채워 지는것을 볼수 있다.  그리고 가로 에서 세로의 배열로 전환될때 이번 순서에서 채워져야 하는 좌표는 가장 마지막 좌표의 Row나 Col이 교환 되는것을 볼수 있다.

  Ex) 4X4행렬을 예로 들었을때,

  가로 방향 (0,0) ~ (0,3)까지 채워 지게 된다. 이후 세로방향 (1,1) ~ (1,3)까지 채워 지는데 여기서 주목해야 할부분은 가로방향 0,3 -> 세로방향 1,3 이 되었다는 점이다. 즉, 가로방향 가장 마지막으로 수행되었던 좌표는 0,3 row=0, col=3 에서 세로 방향 row=1, col=3 가로 방향에서 세로 방향으로 전환될때는 Col이 고정된다는 점이다.



- 구현
	가로->세로 의 전환에서 row, col 둘중에 하나가 고정되는것을 확인 하였다. 

    가로 ->세로 (가장 마지막 으로 입력된 배열의 col고정)

    세로->가로 (가장 마지막 으로 입력된 배열의 row고정)

``` c
ar=(int**)calloc(size,sizeof(int*));
	for(int i=0;i<size;i++){
		ar[i]=(int*)calloc(size,sizeof(int));
	}
//2차원 배열을 N만큼 동적 할당함
int snail(int angle,int *vecter,int *recent_row,int *recent_col,int count,int *arr[],int size)
//angle 가로 세로 방향, vecter plus or minus, recent row&col 최근 좌표
int num_of_blank(int *arr[],int angle,int last_row_or_col,int size)

int find_blank(int *arr[],int angle,int last_row_or_col,int N_by_N,int blank_or_not)

```

배열을 채워 갈때 해당 순서.  
즉, 가로 배열을 채울때(int snail) 현재 채워야할 가로 배열에 빈배열(int find_blank)은 어디부터 시작이고 빈배열의 개수는 몇개(int num_of_blank)인지 를 구해서 빈 배열의수 만큼 현재 count의 값을 저장한다.
  

다른 정답들과 비교해 봤지만 상당히 멍청하게 푼것 같고,  
다른 사람이 보았을때 한번에 이해하기 어려운것 같습니다.  
조금더 가독성있는 코드를 작성하겠습니다.
