---
title: "다양한 패턴 출력"
date: 2018-06-12T12:24:25+06:00
description:

menu:
  sidebar:
    name: 다양한 패턴 출력
    identifier: various-pattern-output
    parent: etc-problems
    weight: 40

tags:
- Study
- C
- Algorithms
- Loop
- Pattern
---


## Variety of star
`다양한 삼각형 출력`

```c
regular triangle
    *
   ***
  *****
 *******
*********
right align of regular triangle
    *
   **
  ***
 ****
*****
right align of regular triangle
*
**
***
****
*****
Inverted triangle
*********
 *******
  *****
   ***
    *
Left align of inverted triangle
*****
****
***
**
*
Right align of inverted triangle
*****
 ****
  ***
   **
    *

```

```c

	int input;
	int space=0;
	int state_num=0;
	scanf("%d",&input);
	printf("\nregular triangle\n");
	space=input;
	for(int i=0;i<input;i++){
		for(int k=0;k<space-1;k++) printf(" ");
			for(int j=0;j<2*i+1;j++){
				printf("*");
			}
			space--;
			printf("\n");
		}
		space=0;
		printf("\nright align of regular triangle\n");
		space=input-1;
		for (int i = 0; i < input; ++i)
		{
			for (int k = 0; k < space; ++k)
			{
				printf(" ");
			}
			for (int j = 0; j < input-space; ++j)
			{
				printf("*");
			}
			printf("\n");
			space--;
		}
		printf("\nright align of regular triangle\n");
		space=input-1;
		for (int i = 0; i < input; ++i)
		{
			for (int j = 0; j < input-space; ++j)
			{
				printf("*");
			}
			printf("\n");
			space--;
		}
		printf("\nInverted triangle\n");
		for (int i = 0; i < input; ++i)
		{
			for (int j = 0; j < i; ++j)
			{
				printf(" ");
			}
			for (int k = (2*i)+1; k <=(input*2-1) ; ++k)
			{
				printf("*");
			}
			puts("");
		}
		space=0;
		//inverted triangle left
		printf("\nLeft align of inverted triangle\n");
		for (int i = 0; i < input; ++i)
		{
			for (int k = 0; k < input-space; ++k)
			{
				printf("*");
			}
			space++;
			printf("\n");
		}
		space=0;
		printf("\nRight align of inverted triangle\n\n");
		//inverted triangle right
		for (int i = 0; i < input; ++i)
		{
			for (int j =0 ; j < space; ++j)
			{
				printf(" ");
			}
			for (int k = 0; k < input-space; ++k)
			{
				printf("*");
			}
			space++;
			printf("\n");
		}
```



## Applied multiplication

`구구단 이쁘게 출력`
```c
2*1=2	3*1=3	4*1=4	5*1=5	
2*2=4	3*2=6	4*2=8	5*2=10	
2*3=6	3*3=9	4*3=12	5*3=15	
2*4=8	3*4=12	4*4=16	5*4=20	
2*5=10	3*5=15	4*5=20	5*5=25	
2*6=12	3*6=18	4*6=24	5*6=30	
2*7=14	3*7=21	4*7=28	5*7=35	
2*8=16	3*8=24	4*8=32	5*8=40	
2*9=18	3*9=27	4*9=36	5*9=45	
6*1=6	7*1=7	8*1=8	9*1=9	
6*2=12	7*2=14	8*2=16	9*2=18	
6*3=18	7*3=21	8*3=24	9*3=27	
6*4=24	7*4=28	8*4=32	9*4=36	
6*5=30	7*5=35	8*5=40	9*5=45	
6*6=36	7*6=42	8*6=48	9*6=54	
6*7=42	7*7=49	8*7=56	9*7=63	
6*8=48	7*8=56	8*8=64	9*8=72	
6*9=54	7*9=63	8*9=72	9*9=81
```
```c
		int tens,unit;
		int count=0;
		count=2;
		for (int i = 2; i < 10; ++i)
		{

			for (int j = 1; j < 10; ++j)
			{
				for (int k = 0; k < 4; ++k)
				{
					printf("%d*%d=%d\t",i+k,j,(i+k)*j );

				}
				puts("");
			}
			i+=3;

		}
```

## Serial of alphabet 

`N번째 부터 연속된 알파벳 출력`

```c
insert one word: t
t
tu
tuv
tuvw
tuvwx
tuvwxy
tuvwxyz
```

```c
		char input;
		char point_en;
		printf("insert one word: ");
		scanf("%c",&input);
		point_en=input;
		while((input)<='z'){

			for (int i = 0; point_en+i <= input; ++i)
			{
				printf("%c",point_en+i );

			}
			input++;
			printf("\n");
		}
```

