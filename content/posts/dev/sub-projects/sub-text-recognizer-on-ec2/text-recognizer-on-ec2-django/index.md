---
title: Django 따라해보기!!
date: 2018-07-31T08:06:25+06:00
menu:
  sidebar:
    name: Django 따라해보기!!
    identifier: text-recognizer-on-ec2-django
    parent: sub-text-recognizer-on-ec2
    weight: 20
tags:
 - Django
 - Python
---



## Django(Framework)

> Django(*/dʒæŋɡoʊ/ jang-goh/쟁고/장고*)는 파이썬으로 만들어진 무료 오픈소스 웹 애플리케이션 프레임워크(web application framework)입니다. 쉽고 빠르게 웹사이트를 개발할 수 있도록 돕는 구성요소로 이루어진 웹 프레임워크랍니다.

### Installation

```shell
$ pip3 install Django
$ python3
>>import django
>>django.VERSION
>>(2.0.1)
```



### 가상환경을 프로젝트 폴더에 적용

pyenv 를 이용하여 가상환경을 적용해 줄겁니다.

[pyenv-installer](https://github.com/pyenv/pyenv-installer) 를 이용해서 설치하면 다른 플러그인도 같이 설치 됩니다.

```shell
$ curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
$ pyenv update

# 현재 사용하고 있는 버전들
$ pyenv versions
* system (set by /Users/Edwardson/.pyenv/version)
  3.6.5
$ pyenv virtualenv 3.6.5 myenv
$ pyenv versions
* system (set by /Users/Edwardson/.pyenv/version)
  3.6.5
  3.6.5/envs/myenv
  myenv

$ mkdir project
# project 폴더로 이동후
$ pyenv local project
(myenv)$ python3 --version
Python 3.6.5
(myenv)$ pip --version
pip 9.0.3 from /Users/Edwardson/.pyenv/versions/3.6.5/envs/myenv/lib/python3.6/site-packages (python 3.6)
# 버전이 너무 낮아서 업글 해줘야댐
(myenv)$ pip install --upgrade pip
(myenv)$ pip install Django

```



## django project 생성

```shell
(myenv)$ django-admin startproject project
.
└── project
    ├── project
    │   ├── __init__.py
    │   ├── __pycache__
    │   │   ├── __init__.cpython-36.pyc
    │   │   ├── settings.cpython-36.pyc
    │   │   ├── urls.cpython-36.pyc
    │   │   └── wsgi.cpython-36.pyc
    │   ├── settings.py
    │   ├── urls.py
    │   └── wsgi.py
    ├── db.sqlite3
    └── manage.py
# 프로젝트 폴더 명도 project 이고 그안에 시작 폴더 이름도 project가 되버린다.
# 때문에 프로젝트 폴더 안의 project를 config로 바꿀것이다.
# 하지만 폴더 명을 바꿔 버리면 영향을 미치는 파일들이 있는데
# manage.py wsgi.py settings.py 이 세개의 파일이다.
# 들어가서 project로 되어있는 부분들을 전부 config로 바꾸자
.
└── project
    ├── config
    │   ├── __init__.py
    │   ├── __pycache__
    │   │   ├── __init__.cpython-36.pyc
    │   │   ├── settings.cpython-36.pyc
    │   │   ├── urls.cpython-36.pyc
    │   │   └── wsgi.cpython-36.pyc
    │   ├── settings.py
    │   ├── urls.py
    │   └── wsgi.py
    ├── db.sqlite3
    └── manage.py
# 아마 이렇게 되어있을것이다.

```







### 실습-1

> django 시작부터 글 모델 데이터 베이스 생성

```shell
# django 시작
$ django-admin startproject mysite

$ python manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying auth.0009_alter_user_last_name_max_length... OK
  Applying sessions.0001_initial... OK
  
# 서버 실행
$ python3 manage.py runserver

# 블로그 만들기
$ python manage.py startapp blog
# mysite/settings.py 에 blog 추가
###
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'blog',
]
###






# blog/model.py 에 다음 내용 추가(블로그 글 모델을 만드는것)
# 글을 쓰기 위한 클래스를 만드는 것이다. 해당 클래스를 통해 글을 쓸수 있는
# 기능을 구현해줄수 있다.
from django.db import models
from django.utils import timezone

class Post(models.Model):
    author = models.ForeignKey('auth.User', on_delete=models.CASCADE)
    title = models.CharField(max_length=200)
    text = models.TextField()
    created_date = models.DateTimeField(
            default=timezone.now)
    published_date = models.DateTimeField(
            blank=True, null=True)

    def publish(self):
        self.published_date = timezone.now()
        self.save()

    def __str__(self):
        return self.title

# 블로그에 필요한 데이터베이스 만들기
$ python manage.py makemigrations blog

Migrations for 'blog':
  blog/migrations/0001_initial.py
    - Create model Post
    
# 데이터 베이스 모델을 위한 테이블 생성 
# 아까 만들었던 글 모델이 데이터 베이스에 저장되었다.
$ python manage.py migrate blog
Operations to perform:
  Apply all migrations: blog
Running migrations:
  Applying blog.0001_initial... OK
  
```



### 장고 관리자



```shell
# admin.py의 내용을 다음으로 바꿈
from django.contrib import admin
from .models import Post

admin.site.register(Post)
# 잘 보면 아까 만들었던 글모델 Post를 import하고 있다.

$ python3 manage.py runserver

# http://127.0.0.1:8000/admin 으로 접속 하면 관리자 화면을볼수 있다
# 관리자를 활성화 해주기 위해 슈퍼 유저 계정을 만들어야 한다.
$ python3 manage.py createsuperuser
Username (leave blank to use 'edwardson'): codex
Email address: ehdwn1991@gmail.com
Password: 
Password (again): 
Superuser created successfully.
```

