---
title: "C언어 Scanf 의 의미"
date: 2020-06-08T08:06:25+06:00
description: Scanf의 조금더 깊이 있게 이해해봤습니다.
menu:
  sidebar:
    name: C언어 Scanf 의 의미
    identifier: the-meaning-of-scanf-in-c-language
    parent: programming-tips
    weight: 40

tags:
- Study
- Programming tips
- C
- Scanf
---

## Scanf 에서 공백과 \n의 의미

먼저 IBM에서 제공하는 Scanf의 정의먼저 보겠습니다.

공백 문자로,[isspace()함수](https://www.ibm.com/support/knowledgecenter/ko/ssw_ibm_i_73/rtref/isalnum.htm?view=kc#isalnum)(줄 바꾸기 문자와 공백과 같은)에서 지정됩니다.

공백 문자로 `scanf`함수는 공백이 아닌 다음 문자까지 입력의 모든 연속 공백 문자를 읽지만 저장하지 않습니다. format-string의 한 공백 문자는 입력에서 공백 문자의 조합과 일치합니다.

퍼센트 기호 문자(%)를 제외하고, 공백이 아닌 문자입니다.

공백이 아닌 문자로scanf()함수는 일치하는 공백이 아닌 문자를 읽지만 저장하지 않습니다.

stdin의 다음 문자가 일치하지 않는 경우,scanf()함수가 종료합니다.

 

 

## 예제

```c
#include <stdio.h>
int main(){
    int a,b;
    scanf("%d ",&a);
    printf("%d\n",a);
    scanf("%d ",&b);
    printf("%d\n",b); }
```



```shell
$ ./a.out
1
1
2
2
```



우리가 1을 입력후 엔터를 치면 1이 출력되고 그다음 2를 입력하면 2가 출력 될것이라고 예상할것이다.

```c
$ ./a.out
1
2
1
q
2
```

하지만 1을 입력후 2를 입력해야 1이 출력되고 q를 입력하자 2가 출력된다 왜일까?

scanf("%d ",&a) 를 해석해 보자 %d뒤에 공백이 있는데, 이 부분에서

`숫자, 1자 이상의 공백문자, 공백문자가 아닌 문자값`이 들어오기를 기다립니다.


그렇다면 1을 입력후에는 버퍼안에 1이 들어가있고


그다음 공백 문자 이외의 문자를 기다립니다.


물론 우리는 엔터를 통해 '\n'을 입력했지만 New line은 문자로 할당되지 않습니다.


그리고 다음 기대 값인 2를 입력 했을때 비로소 공백이 아닌 문자가 들어오게 된것이죠.


그래서 버퍼에있던 1을 출력해 주고 현재 버퍼엔 2가 남아있게 됩니다.


그리고 아무 문자를 입력하고 나면 공백이아닌 문자가 들어왔기 때문에


2가 출력되게 되는것입니다.


그리고 프로그램이 끝나기 전까지는 버퍼에 마지막 입력했던 문자가 들어있겠지요.



## 참고

[IBM Scanf 정의](https://www.ibm.com/support/knowledgecenter/ko/ssw_ibm_i_73/rtref/scanf.htm)
[여기 참고](http://electro-don.tistory.com/entry/scanf-n-%EA%B4%80%EB%A0%A8)