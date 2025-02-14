---
title: "Python 기초"
date: 2018-06-11T04:22:12+06:00
description: C언어 관련 이론 정리
menu:
  sidebar:
    name: Python 기초
    identifier: basic-python
    parent: sub-python
    weight: 30
tags:
- Study
- Python
- Theory
---


## 파이썬 basic

> 플랫폼 독립적이며 인터프리터식, 객체지향적, 동적 타이핑(Dynamically typed) 대화형 언어 이다.
>
> 파이썬이 유지보수가 쉬운 이유는 `가독성이 좋아서 ` 이다.
>
> 파이썬으로 프로그래밍시 주의할 점은 Name Space 이다.
>
> 이미 존재하는 라이브러리와 같은 이름으로 저장시 overiiding의 문제가 발생할수도 있다.
>
> 다중 패러다임(함수형, 명령형, 객체지향- 클래스 기반) 프로그래밍 언어 이다.

* 언어의 종류

  C - python

  Java - jython

  .net - Iron python

  python - pypi(속도 향상을 위해 파이썬 기반으로 제작)

* 주의 사항

  * Name space 주의

    이미 존재하는 라이브러리와 같은 이름으로 저장시 Overriding 문제 발생.

  * 들여 쓰기 주의

    파이썬은 Code Block(`{}` 중괄호)이 없기 때문에 구획을 들여쓰기로 구분한다.

    변수 대입시에도 1칸 이상 띄어쓰는것은 주의해야 한다.

    새로운 블록의 시작은 조건문, 반복문, 함수 부분에서 끝에 `:` 을 붙여준다.

* 변수

  입력에 따라 알아서 데이터 타입이 정해진다. 즉, 정수, 실수, 음의정수, 문자열등 대입시에

  자동으로 결정된다.

  * 가능한 변수명

    3.6	버전 부터는 한글 변수명도 가능하며, 첫글자는 영문 혹은`_` 로 시작해야 한다.

  * 불가능한 변수명

    숫자로 시작하거나 특수문자로 사용되는변수명

    특정 예약어를 사용한 변수명

> 예약어는 True False 같은 언어 내부에서 통용되는 단어 이다. 대부분의 예약어는 다른 언어를   
>
> 공부해봤다면 충분히 비슷한것이 많기 때문에 걱정할필요 없다.
>
> 하지만 예약어가 뭐가 있는지 확인해볼 필요는 있다.
>
> 

```python
import keyword
print(keyword.kwlist)
['False', 'None', 'True', 'and', 'as', 'assert', 'break', 'class', 'continue', 'def', 'del', 'elif', 'else', 'except', 'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is', 'lambda', 'nonlocal', 'not', 'or', 'pass', 'raise', 'return', 'try', 'while', 'with', 'yield']
```



* Casting

  * 숫자형 casting

    정수형, 실수형으로 casting이 가능하다.

    ```python
    >>int(3.4)
    3
    >>float(8/2)
    4.0
    ```

  * 문자형 casting

    두가지의 casting이 가능하다. `str` , `repr` 두가지가 있는데 예제로 살펴보자.

    `str()` 

    비공식적인 문자열을 출력하며, 단지 문자열로만 바꿔줄 뿐이다.

    `repr`

    공식적인 문자열을 출력하며, 새로운 문자열 객체로 만들어준다.

    위키독스의 점프투 파이썬을 참고해 보자.

    ```python
    #str 예제
    >>> a = "Life is too short"
    >>> b = str(a)
    >>> eval(b)
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
      File "<string>", line 1
        Life is too short
                        ^
    SyntaxError: unexpected EOF while parsing
    #repr 예제
    >>> a = datetime.datetime(2017, 9, 27)
    >>> b = repr(a)
    >>> eval(b)
    datetime.datetime(2017, 9, 27, 0, 0)
    
    >>> a = "Life is too short"
    >>> b = repr(a)
    >>> eval(b)
    'Life is too short'
    ```

    위의 코드처럼 repr은 새로운 객체로 만들어서 eval로 실행할때 새로운 문자열 객체를 실행한다.

* 문자열 다루기

  ```python
  >>>x= 'a'
  >>>word = "hello" + x
  >>>print(word)
  helloa
  >>>print(word+'b')
  helloab
  >>>print(word)
  helloa
  >>>print('He' 'she')
  Heshe
  >>>print(word[-1],word[-2])
  a o
  
  ```

  부분 문자열을 -1로 indexing하면 가장 오른쪽의 문자가 출력된다.

  그럼 특정 문자를 바꾸는것은 가능할까? 결론은 불가능이다.

  ```python
  >>>word[-1]='w'
  TypeError: 'str' object does not support item assignment
  ```

  문자열은 불가변성(immutable) 이기 때문에 수정이 불가능하다. 하지만 문자를 추가하여 새로운 

  문자열로 assign하는것은 가능하다.

  * % 문자열 연산자 사용법

    %문자열 연산자를 사용하면, 문자열이 아닌것도 문자열 형태로 변환해서 출력하는것이 가능하다.

    ```python
    >>>print("%s qwe %d"%("abc",100))
    abc qwe 100
    ```

  * 결합연산자 와 결합

    ```python
    #결합 연산자 사용
    >>>print("a"+"b")
    ab
    #이어 붙이기
    >>>print("a""b")
    ab
    # 쉼표(,)로 결합하면 자동으로 공백이 들어간다.
    >>>print("a","b")
    a b
    
    ```

* 연산자 우선 순위

  다음 표는 위에서 부터 밑으로 우선순위를 나타낸 것이다.

  ```python
  Operator	Description
  **			지수 (전원으로 인상)
  ~ + -		Ccomplement, 단항 플러스와 마이너스 (마지막 두의 메서드 이름은 + @이며, - @)
  * / % //	곱하기, 나누기, 나머지, 몫
  + -			덧셈과 뺄셈
  >> <<		좌우 비트 시프트
  &			비트 'AND'
  ^ |			비트 전용 'OR'와 정기적 인 'OR'
  <= < > >=	비교 연산자
  <> == !=	평등 연산자
  = %= /= //= -= += *= **=	할당 연산자
  is is not	식별 연산자
  in not in	맴버 연산자
  not or and	논리 연산자
  
  ```

  연산자 우선순위가 존재한다. 하지만 다른 언어들 처럼 꼭 우선순위대로 처리되는것은 아니다.

  예를 들어보자.

  ```python
  #case1
  >>>a = 1+2<<3
  >>>print(a)
  24
  #case2
  >>>a = 2*2<<3
  >>>print(a)
  32
  #case3
  >>>a=1
  >>>not a>5
  ```

  case1

  연산자 우선 순위에서 단항자 연산자(+)가 쉬프트 연산자(<<)보다 우선순위가 높다.

  때문에 1+2=3 을 왼쪽으로 3번 쉬프팅 한다.0011 -> 0110 -> 1100 -> 0001 1000(24) 가 된다.  

  

  case2

  연산자 우선순위에서 곱(*) 연산자가 쉬프트(<<)보다 우선순위가 높다.

  예상 대로 라면 2*2=4 왼쪽 세번 리프팅. 0100 -> 1000-> 0001 0000-> 0010 0000(32)  

  

  case3

  연산자 우선 순위에서 논리연산자(not)이 비교연산자(>)보다 우선순위가 낮다.

  때문에 a>5 는 false이고 















##  Unicode

`from *future* import unicode_literals`를 통해 Python 3 처럼 `u` 마커없이 기본 유니코드로 간주한다. 단, `unicode_literals`를 사용하지 않는 다른 라이브러리와의 연동시 매우 유의해야 한다.



```
from __future__ import print_function
파이썬 2에서 3처럼 쓸수 있게 해줌
```


## Tips

### Sublimetext3 에서 python 사용

* 설정

  command+` => [package Control](https://packagecontrol.io/installation)에 있는 코드 삽입.

  Shift + Command + p 눌러서 p i (package control : install package) 실행하여 세부 패키지 설치

* Compile

  Command+B

* [pip installation](https://pip.pypa.io/en/stable/installing/)

* [개발 환경 분리](http://guswnsxodlf.github.io/pyenv-virtualenv-autoenv)

* [Ipython installatino](https://ipython.org/install.html)

* python notebook install  

  `$ ipython nootbook`  

  현재 있는 폴더를 웹에서 접근 가능. 웹안에서 컴파일은 물론 많은 기능 가능.

