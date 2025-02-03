---
title: "파스칼의 삼각형"
date: 2018-09-13T12:24:25+06:00
description:

menu:
  sidebar:
    name: 파스칼의 삼각형
    identifier: prob-pascal-triangle
    parent: etc-problems
    weight: 40

tags:
- Study
- C
- Math
- Algorithms
---


## Pascal Triangle

C 언어를 활용해서 "파스칼의 삼각형(PascalTriangle)"을 출력하는 프로그램을 분석해보려고 합니다.   
파스칼의 삼각형은 수학에서 조합론과 이항계수와 관련이 깊은 구조인데요,  
이를 C 언어로 구현한 코드와 함께 살펴보겠습니다!


### 파스칼의 삼각형이란?

파스칼의 삼각형은 다음과 같은 규칙을 가지고 있어요.
 - 가장 바깥쪽 숫자는 항상 1이다.
 - 내부의 각 숫자는 바로 위 행의 양옆 숫자의 합이다.
 - N번째 행에는 (N+1)개의 요소가 존재한다.

예를 들어, N = 5일 때 파스칼의 삼각형은 이렇게 출력됩니다.  

```txt
    1    
   1 1   
  1   1  
 1 1 1 1
1   1   1
```


### 파스칼의 삼각형 구현

`구현 포인트`
* 동적 메모리 할당 (malloc())을 활용해 2차원 배열을 구현
* 홀수 값을 기준으로 출력하는 방식 적용
* 메모리 해제를 철저히 관리하여 메모리 누수를 방지
  
`파스칼의 삼각형`  

```c
#include <stdio.h>
#include <stdlib.h>
int main(){
	int N;
	scanf("%d",&N);
	int **row;
	row=(int**)malloc(sizeof(int*)*N);

	for (int i = 0; i < N; ++i)
	{
		row[i]=(int*)malloc(sizeof(int)*((N*2)-1));
	}
	for (int i = 0; i < N; ++i)
	{
		for (int j = 0; j < i+1; ++j)
		{
			if(j==0||j==i){
				*(*(row+i)+(N-1+(j*2)-i))=1;
			}
			else{
				*(*(row+i)+(N-1-i+(j*2)))=(*(*(row+i-1)+(N-1-i-1+(j*2))))+(*(*(row+(i-1))+(N-1-i+(j*2)+1)));
			}
		}
	}
	for (int i = 0; i < N; ++i)
	{
		for (int q = 0; q < (N*2)-1; ++q)
		{
			if(*(*(row+i)+q)%2==1)
			// if(*(*(row+i)+q)!=0)
				printf("%d",*(*(row+i)+q));
			else{
				printf(" ");
			}
		}
		free(*(row+i));
		puts("");
	}
}
```

<details>
<summary>코드 분석</summary>

#### 코드 분석

이제 코드가 어떻게 동작하는지 하나씩 살펴볼게요.

1. 메모리 동적 할당   
    ```c
    int **row;
    row = (int**)malloc(sizeof(int*) * N);
    ```
    row는 2차원 배열을 위한 포인터 배열입니다.  

    N개의 행을 위한 메모리를 할당합니다.  
    ```c
    for (int i = 0; i < N; ++i) {
        row[i] = (int*)malloc(sizeof(int) * ((N * 2) - 1));
    }
    ```
    각 행(row)마다 (N * 2) - 1 크기의 배열을 동적 할당합니다.  
    이 배열은 파스칼 삼각형을 가운데 정렬하기 위한 역할을 합니다.  

2. 파스칼 삼각형 값 계산
    ```c
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < i + 1; ++j) {
            if (j == 0 || j == i) {
                *(*(row + i) + (N - 1 + (j * 2) - i)) = 1;
            } else {
                *(*(row + i) + (N - 1 - i + (j * 2))) = (*(*(row + i - 1) + (N - 1 - i - 1 + (j * 2)))) + (*(*(row + (i - 1)) + (N - 1 - i + (j * 2) + 1)));
            }
        }
    }
    ```

    `j == 0` 또는 `j == i`일 때는 1을 배치합니다.  
    나머지는 윗줄에서 두 숫자를 더해서 채웁니다.  

3. 출력 및 메모리 해제
    ```c
    for (int i = 0; i < N; ++i) {
        for (int q = 0; q < (N * 2) - 1; ++q) {
            if (*(*(row + i) + q) % 2 == 1)
                printf("%d", *(*(row + i) + q));
            else
                printf(" ");
        }
        free(*(row + i));
        puts("");
    }
    free(row);
    ```
    (N * 2) - 1 크기의 배열을 출력하면서 홀수만 보이도록 출력합니다.  
    메모리 누수를 방지하기 위해 free()를 사용하여 할당된 메모리를 해제합니다.  



</details>