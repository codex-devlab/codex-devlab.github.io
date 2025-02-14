---
title: "기초 문제"
date: 2018-06-14T12:24:25+06:00
description:

menu:
  sidebar:
    name: 기초 문제
    identifier: basic-problem
    parent: etc-problems
    weight: 40

tags:
- Study
- C
- Algorithms
- Prime Number
- Sort
---


## Find the prime number
`에라토스테네스의 체 소수 찾기`
```c
int N,count=1;
    printf("에라토스테네스의 체 소수 찾기\nN까지의 소수를 찾습니다.\ninsert: ");
    scanf("%d",&N);
    char *arr=(char*)malloc(sizeof(char)*N);
    memset(arr,1,sizeof(char)*N);
    puts(arr);
    for (int i = 2;  (i*i)<= N; ++i) //루트 N까지만 체크
    {
        if(arr[i]==1){
            for (int j = i*i; j < N; j+=i)
            {
                arr[j]=0;//1 is prime 0 is not prime
            }
        }

    }

    for (int i = 2; i < N; ++i)
    {
        if(arr[i]==1){
            printf("%d ",i);
            if(count%10==0)
                puts("");
            count++;
        }
    }
    free(arr);
    puts("");
```
## Buble sort
`Buble 정렬`
```c
int buff[5] = { 7, 2, 9, 3, 8 };
    int idx = 0;
    int cnt = 0;
    int temp = 0;
    int len = 0;
    len = sizeof(buff) / sizeof(int);
    printf("----정렬 전 데이터 출력----\n");
    for (idx = 0; idx < len; idx++)
    {
        printf("%3d ", buff[idx]);
    }
    printf("\n\n");

    for (int i = 0; i < len; ++i)
    {
        for (int j = len-1; j >i; --j)
        {
            if(buff[j-1]>buff[j]){
                temp=buff[j-1];
                buff[j-1]=buff[j];
                buff[j]=temp;
            }
        }
    }

    printf("----정렬 후 데이터 출력----\n");
    for (idx = 0; idx < len; idx++)
    {
        printf("%3d ", buff[idx]);
    }
    printf("\n");

```

## Area of ​​circle
```c
double radius=0;
    printf("원의 반지름 입력 : ");
    scanf("%lf", &radius);
    printf("반지름에 따른 원의 넓이 : %.3lf\n", radian(radius));

    clearbuff();
```

## Calculator
```c
int a=0,b=0;
    char operater;
    printf("x(operater)y 순으로 입력해주세요.\n");
    scanf("%d%c%d",&a,&operater,&b);
    switch(operater){
        case '+':
        printf("%d%c%d=%d\n",a,operater,b,add(a,b) );
        break;
        case '-':
        printf("%d%c%d=%d\n",a,operater,b,sub(a,b) );
        break;
        case '*':
        printf("%d%c%d=%d\n",a,operater,b,mutiple(a,b) );
        break;
        case '/':
        printf("%d%c%d=%.1f\n",a,operater,b,div_my(a,b) );
        break;

    }
...
int add(int a,int b){
    return a+b;
}

int sub(int a,int b){
    return a-b;

}

int mutiple(int a,int b){
    return a*b;
}

double div_my(int a,int b){

    return (double)a/b;
}
```