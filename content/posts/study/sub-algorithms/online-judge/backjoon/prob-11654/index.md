---
title: Problem.11654
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Problem.11654
    identifier: backjoon-11654
    parent: backjoon
    weight: 50
tags:
- C
---


> [백준 단계별 문제집 레벨 3](https://www.acmicpc.net/step/3)  
> [모든 내용은 Git Hub에도있습니다.](https://github.com/ehdwn1991/Coding-Interview/blob/master/Code_Interview_Prep_Platform/backjoon/Level_7/11654.c)


## Level7

{{< details >}}
Collapsed text
{{< /details >}}

## [Problem.11654](https://www.acmicpc.net/problem/11654)
`아스키 코드`
```c
#include <stdio.h>
int main(){
	char a;
	while((a=getchar())!=EOF){
		if(a!=10)
			printf("%d\n",a);
	}
}
```



## [Problem.10809](https://www.acmicpc.net/problem/10809)
`10809번알파벳 찾기`
```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(){
	char comp_alpha[26]="abcdefghijklmnopqrstuvwxyz";
	int comp_location[26]={0,};
	char buf[110]={'\0',};
	for(int i=0;i<26;i++){
	comp_location[i]=-1;
	}
	fgets(buf,sizeof(buf),stdin);
    //a~z까지 입력된단어에서의 처음 위치를 찾는다
	for(int i=0;i<26;i++){
		for(int j=0;j<strlen(buf);j++){
			if(buf[j]==comp_alpha[i]){
				comp_location[i]=j;
				break;
			}
		}
	}
for(int i=0;i<26;i++){
printf("%d ",comp_location[i]);
}
puts("");
}

```

>알파벳은 26개이다 각 단어에서 알파벳이 처음 등장 하는 위치를 다른 배열에 저장한다.
>
>반복문에서 처음 위치를 찾으면 break 되기 때문에
>
>중복이 되서 그다음 위치가 저장될일이 없다.



##[Problem.2675](https://www.acmicpc.net/problem/2675)
`문자열 반복`
```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void QR_code();
int main(){
	int N;
	char buf[24]={'\0',};
//	문자는 20글자 앞에 반복횟수 N  공백 까지 22에 마지막 엔터 23으로 되야 하는데 안되서 24로 잡음
	scanf("%d",&N);
	while(getchar()!=10);
	for(int i=0;i<N;i++){
		fgets(buf,sizeof(buf),stdin);
				QR_code(buf);
				puts("");
	memset(buf,'\0',strlen(buf));
}
}
void QR_code(char *q){		
	for(int i=2;i<strlen(q)-1;i++){
		for(int j=0;j<(*q)-48;j++){
			printf("%c",*(q+i));
		}			
}
}

```

##[Problem.1157](https://www.acmicpc.net/problem/1157)
`단어 공부`
```c
#include <stdio.h>
#include <string.h>
int main(){
	int alpha[26]={0,};
//	정수형 배열을 쓰는 이유는 단어의 길이가 1000000이기 때문에 반복된
//	알파벳의 횟수가 127번을 넘어가면 CHAR형의 범위를 넘어버린다.
	char temp;
	int Max_comp=0;
	int comp2=0;
	int comp1=0;
    //각 단어가 들어왔을때 대소문자 상관없이 각 문자 마다 카운트 한다.
	while((temp=getchar())!=10){
		if(temp>64&&temp<91){
		//대문자 일때
			alpha[temp-65]+=1;
		}
		else{
	//		소문자 일때
			alpha[temp-97]+=1;
		}
	}
	//가장 많이 사용되 문자 찾는과정
	for(int i=0;i<26;i++){
		if(alpha[i]!=0){
			Max_comp=(Max_comp>alpha[i]?Max_comp:alpha[i]);
	}
	}
	
	for(int j=0;j<26;j++){
		if(Max_comp==alpha[j]){
			comp1=j;
			comp2++;//가장 많이 사용된 문자의 갯수를 저장	
		}
	}
	
	if(comp2>1){
	printf("?\n");
	//가장 많이 사용한 문자가 2개이상 일때는 ?를 출력
	}
	else
	printf("%c\n",comp1+65);
	//가장 많이 사용한 문자가 2개 미만일때는 해당 문자 출력
}
```
>가장 많이 사용된 문자의 갯수를 문자별로 배열에 저장하고,
>가장많이 사용된 문자를 찾아 다시 비교해 주면된다.
>비교 하는 과정에서 가장큰 문자는 1번만 나와야하고 2번 이상 나온다면 "?"를 출력해주어야 한다.


##[Problem.1316](https://www.acmicpc.net/problem/1316)
`그룹 단어 체커`
```c
#include <stdio.h>
#include <string.h>
int checker();
int main(){
	int N;
	char buf[101]={'\0',};
	int result=0;
	scanf("%d",&N);
	for(int i=0;i<N;i++){
		scanf("%s",buf);
		result+=checker(buf);
	}
printf("%d\n",result);



} 

int checker(char *q){
	char alpha[101]={'\0'};
	int duplicate_count=0;
	for(int i=0;i<strlen(q);i++){
		if(alpha[duplicate_count]==0&&alpha[duplicate_count-1]!=(*(q+i)))		{//알파벳 배열에 연속된 같은 문자의 중복을 피하고 저장 
			alpha[duplicate_count]=(*(q+i));
			duplicate_count++;
		}
	}

	for(int j=0;j<strlen(alpha);j++){
		for(int k=j+1;k<strlen(alpha);k++){
			if(alpha[j]==alpha[k]){
			//j번째의 문자가 j+1번째부터 배열의 길이 까지
			//한번이라도 나오면 연속단어가 성립 안됨
				return 0;
			}
		}
	}
return 1;
}
```
>입력 받은 문장에서 단어를 체크하는 함수로 입력받은 문장의 주소 전달.
>문장에서 연속된 문자의 중복을 제거하면서 한번씩만 배열에 저장
>이후 N번째의 문자가 N+1번째부터 끝까지
>한번이라도 나온다면 연속문자가 아님.

##[Problem.2908](https://www.acmicpc.net/problem/2908)
`상수`
```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(){
	char buf[8]={0,};
	int start_num=2;
	fgets(buf,sizeof(buf),stdin);
	for(int i=3;0<i;i--){
		if(buf[i-1]>buf[i+3]&&(buf[i-1]!=buf[i+3])){
		//각 숫자의 가장 뒷부분을 비교 여기서 큰쪽이 큰수가 된다.
		//같은 수인걸 조건으로 배제해야 한다.
			start_num=2;
			break;
			}
		else{
			if(buf[i-1]<buf[i+3]&&(buf[i-1]!=buf[i+3])){
			start_num=6;
			break;
			}
		}				
	}
	//만약 두수가 111 111이라면 같은 수이므로 위의 반복문을 돌고 나서
	//start_num에는 아무 변화가 없을것이다. 그래서 초기값으로 2를 넣어줌
	for(int j=0;j<3;j++){
	printf("%c",buf[start_num-j]);
	//두 수를 비교해서 큰숫자가 판명 나면 그 숫자의 시작 번호를 받아와 거꾸로 출력
	}
	puts("");
}
```

##[Problem.5622](https://www.acmicpc.net/problem/5622)
`다이얼`
```c
#include <stdio.h>
#include <string.h>
int main(){
	char buf[16]={'\0',};
	int result=0;
	scanf("%s",buf);
	for(int i=0;i<strlen(buf);i++){
		if(buf[i]>=65&&buf[i]<=67)
			result+=3;	
		else if(buf[i]>=68&&buf[i]<=70)
			result+=4;
		else if(buf[i]>=71&&buf[i]<=73)
			result+=5;
		else if(buf[i]>=74&&buf[i]<=76)
			result+=6;
		else if(buf[i]>=77&&buf[i]<=79)
			result+=7;
		else if(buf[i]>=80&&buf[i]<=83)
			result+=8;
		else if(buf[i]>=84&&buf[i]<=86)
			result+=9;
		else	
		result+=10;
	}
	printf("%d\n",result);
}
```
>그냥 조건에 맞춘 노가다 인듯 싶다...중요한건 다이얼에서 1과 0은 입력이 없다고 보면 된다.
>2~9까지의 수만 쓰인다 생각하고 풀면됨

##[Problem.2941](https://www.acmicpc.net/problem/5622)
`크로아티아 알파벳`
```c
#include <stdio.h>
#include <string.h>
int main(){
	char buf[101]={'\0',};
	int croatia=0;
	scanf("%s",buf);
	for(int i=0;i<strlen(buf);i++){
		if(buf[i]=='c'&&(buf[i+1]=='='||buf[i+1]=='-')){
			croatia++;
			i+=1;
		}
		else if(buf[i]=='d'){
			if(buf[i+1]=='z'&&buf[i+2]=='='){
				croatia++;
				i+=2;
			}
			else if(buf[i+1]=='-'){
				croatia++;
				i+=1;
			}
			else{
			croatia++;
			}
		}
		else if(buf[i]=='l'&&buf[i+1]=='j'){
			croatia++;
			i+=1;
		}		
		else if(buf[i]=='n'&&buf[i+1]=='j'){
			croatia++;
			i+=1;
		}		
		else if(buf[i]=='s'&&buf[i+1]==61){
			croatia++;
			i+=1;
		}
		else if(buf[i]=='z'&&buf[i+1]=='='){
			croatia++;
			i+=1;
		}
		else{
			croatia++;
		}
	}
printf("%d\n",croatia);
}
```
>이것도 조건에 맞춘 노가다 인듯 싶다.
