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

 

> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Dynamic/9461.c)

## [9461번](https://www.acmicpc.net/problem/9461)

파도반 수열은 간단하다.  
처음 배열 1 1 1 1 2 2 를 시작으로   
PD[n]=PD[n-1]+PD[n-5]의 식이 성립되지만 처음에 이렇게 접근하지 않았다.  
파도반은 정삼각형과 역삼각형으로 이루어져있음

|        |  0   |  1   |  2   |
| :----: | :--: | :--: | :--: |
| 정삼각 |  1   |  1   |  2   |
| 역삼각 |  1   |  2   |  3   |

위의 표를 잘 보자 문제에서 처음 시작은 정삼각형 1부터 시작 그다음은 역삼각 1이다.  
그럼 다음 차례 정삼각[1]의 값을 찾아야 하는데 이건 정삼각[1]=정삼각[0]+역삼각[-1]이다. --> `대각의 합`  
그래서 정삼각[1]은 =1이 된다.  
다음은 역삼각 [1]이다. 역삼각[1]=정삼각[0]+역삼각[0]으로 구할수 있다. --> `수직의 합`  
즉 배열 두개와 각 배열의 값을 구해주는 함수 두개가 필요하다.  
정삼각은  Up_triangle, 역삼각은 Down_triangle로 만들자.  
그리고 수열의 특성상 int의 범위를 넘겨 버린다.  그래서 각 배열과 함수의 자료형은 long long으로 해준다.  

```c
#include <stdio.h>
long long vertical_plus();
long long diagonal_plus();
int main(){
	int N,count=0,test_case;
	int iterate_N; 	
	long long up_triangle[50]={0,};
	long long down_triangle[50]={0,};
	scanf("%d",&test_case);
	for(int i=0;i<test_case;i++){
	scanf("%d",&N);
	iterate_N=N;
	up_triangle[0]=down_triangle[0]=1;
	printf("\ncount: %d\n",count);
	while(2<iterate_N){
	up_triangle[count+1]=diagonal_plus(up_triangle,down_triangle,count);
	iterate_N--;
	down_triangle[count+1]=vertical_plus(up_triangle,down_triangle,count);
	iterate_N--;
	count++;
	}
	count=0;
	
	if(N%2!=0)
	printf("%lld\n",up_triangle[(N/2)]);
	else
	printf("%lld\n",down_triangle[(N/2)-1]);

	}
}

long long vertical_plus(long long *up,long long *down,int count){
return *(up+count)+*(down+count);
	}

long long diagonal_plus(long long *up,long long *down,int count){
	if(count==0)
		return *(up+count); // [-1]의 주소를 참조하는것을 방지
return *(up+count)+*(down+count-1);
}
```



