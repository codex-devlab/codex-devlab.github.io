---
title: AWS project 진행 과정
date: 2018-07-31T08:06:25+06:00
menu:
  sidebar:
    name: AWS project 진행 과정
    identifier: text-recognizer-on-ec2-dev-history
    parent: sub-text-recognizer-on-ec2
    weight: 20
tags:
 - Django
 - Python
 - AWS
---



## gui 변경

> 사전에 맥에 vncviewer를 설치해 줬다.
>
> 아마 대부분 유저들이 사용하는 팀뷰어 같은 앱이라고 생각하면 편하다.

설치하면서 [stackoverflow](https://stackoverflow.com/questions/25657596/how-to-set-up-gui-on-amazon-ec2-ubuntu-server)를 참고 하였다.



```bash
# aws 우분투 서버 접속후
$ sudo apt-get update
$ sudo apt-get install gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
$ sudo apt-get install ubuntu-desktop
$ sudo apt-get install vnc4server


ubuntu@ip-172-31-19-48:~$ vncserver

You will require a password to access your desktops.

Password:
Password must be at least 6 characters - try again
Password:
Password must be at least 6 characters - try again
Password:
Verify:
xauth:  file /home/ubuntu/.Xauthority does not exist

New 'ip-172-31-19-48:1 (ubuntu)' desktop is ip-172-31-19-48:1

Creating default startup script /home/ubuntu/.vnc/xstartup
Starting applications specified in /home/ubuntu/.vnc/xstartup
Log file is /home/ubuntu/.vnc/ip-172-31-19-48:1.log

$ vncserver -kill :1
$ exit

# 우분투 서버 재접속
cd /vnc
sudo vi xstartup

#insert this script-------------------------------------#
export XKL_XMODMAP_DISABLE=1
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &

gnome-panel &
gnome-settings-daemon &
metacity &
nautilus &
gnome-terminal &
#-------------------------------------------------------#

# 이후 서버에 접속 할때마다
```



###  연결 주소 확인

![img](../../assets/img/post/S_2018-07-27_10.46.24.png)


```bash
# 만약 aws에서 중지를 하거나 재부팅을 했을때 동적 ip를 사용 하기 때문에
# 매번 퍼블릭 DNS가 바뀌게 된다. 그래서 aws에서 연결 주소 확인!!

# 5901은 vnc로 접속할 포트 번호이다. 다른 포트번호를 써봤지만 안됨.
# 아직 이부분은 공부가 안되어 있어서 모르겠다.
$ sudo ssh -L 5901:localhost:5901 -i "codex_aws.pem" ubuntu@ec2-13-209-3-217.ap-northeast-2.compute.amazonaws.com

Welcome to Ubuntu 16.04.4 LTS (GNU/Linux 4.4.0-1060-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

56 packages can be updated.
29 updates are security updates.


$ vncserver -geometry 1920x1080
New 'ip-172-31-19-48:1 (ubuntu)' desktop is ip-172-31-19-48:1

Starting applications specified in /home/ubuntu/.vnc/xstartup
Log file is /home/ubuntu/.vnc/ip-172-31-19-48:1.log


# vnc viewer 에서 다음 입력
localhost:5901

```

![S_2018-07-27_10.44.04](../../assets/img/post/S_2018-07-27_10.44.04.png)



## 서버 접속

```shell
# AWS에서 연결 들어가서 주소 확인
# aws에 나오는 연결 부분 그대로 복사
$ ssh sudo ssh -L 5901:localhost:5901 -i "여러분꺼.pem" ubuntu@어쩌구 저쩌구 주소
# 접속 성공
```









## 우분투 서버에 파이썬 환경 설정

```bash
# pyenv 로 설치 -> https://github.com/pyenv/pyenv-installer
$ curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
Update:

$ pyenv update
Uninstall: pyenv is installed within $PYENV_ROOT (default: ~/.pyenv). To uninstall, just remove it:

$ rm -fr ~/.pyenv
and remove these three lines from .bashrc:

export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

If you need, export USE_GIT_URI to use git:// instead of https:// for git clone.


# 파이썬 확인
$ python --version
Python 2.7.12
$ python3 --version
Python 3.5.2

# 파이썬이 기본적으로 설치 되어 있음
# 이제 pip3 를 설치할 차례
$ sudo apt install python-pip
# pip버전이 낮다고 나온다면
$ pip install --upgrade pip
$ sudo apt install python3-pip
pip 8.1.1 from /usr/lib/python3/dist-packages (python 3.5)
# 만약 다음과 같은 에러가 나온다면 이 명령 실행
# You are using pip version 8.1.1, however version 18.0 is available.
# You should consider upgrading via the 'pip install --upgrade pip' command.
$ sudo -H pip3 install --upgrade pip

# 갑자기 에러 나오기 시작함
# pip, pip3 버전체크 하는데 둘다 똑같이 밑의 에러를 토해냄
Traceback (most recent call last):
  File "/usr/bin/pip", line 9, in <module>
    from pip import main
ImportError: cannot import name main
# 
$ sudo python3 -m pip uninstall pip && sudo apt install python3-pip --reinstall

# 이제 ipython jupyter  설치
$ pip3 install ipython
$ pip3 install jupyter


# 파이썬 설치후 배포할때에 필요한 라이브러리에 대한 정보를 알리기 위해
$ pip freeze > requirements.txt
```







### Jupyter notebook execution

![S.2018-07-27.9.17.27](../../assets/img/post/S.2018-07-27.9.17.27.png)



## Python Virtual environment installation



### AWS E2C에 설치

```shell
# 서버에 설치
$ sudo apt install virtualenv
$ virtualenv myvenv
# venv 설치 확인
$ source myvenv/bin/activate

#venv 종료
(myvenv)~$ deactive 

$ python3 -m virtualenv myvenv
$ virtualenv myvenv --python=python3
$ virtualenv myvenv --python=python3.5



```



### Mac 에 설치

[참고](http://guswnsxodlf.github.io/pyenv-virtualenv-autoenv)

```shell
# pyenv 설치
$ brew install pyenv
$ brew install pyenv-virtualenv
$ pyenv versions
* system (set by /Users/Edwardson/.pyenv/version)
  3.6.5
#최신 버전설치
$ pyenv install --list
...
3.6.5
...
$ pyenv install 3.6.5
# 특정 버전으로 이동
$ pyenv shell X.X.X(바꾸고 싶은 버전)

# pyenv 로 myenv virtualenv 생성
$ pyenv virtualenv 3.6.5 myenv
# 확인
$ pyenv versions
* system (set by /Users/Edwardson/.pyenv/version)
  3.6.5
  3.6.5/envs/myenv
  myenv  => 해당 폴더는 /Users/Edwardson/.pyenv/version 안에 존재함

# 근데 우리는 서버랑 같은 환경에서 만들고 싶기 때문에
# virtualenv 를 사용한다.
$ virtualenv myenv
$ ls
...
myenv
..
$ cd myenv
$ source bin/activate
(myenv)$ python --version
Python 3.6.5
(myenv)$ pip --version
pip 18.0 from /Users/Edwardson/Dropbox/Codex/Coding_in_Mac/aws_project/myenv/lib/python3.6/site-packages/pip (python 3.6)

```



```shell
# pyen 설치시 ctype 에러 날떄
$ sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils
```



```shell
병신 같은 에러 남 자꾸 터미널에서 인식을 못함
일단 https://github.com/pyenv/pyenv#installation
여기 참고하자
$ $ echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile

```







## Django 설치

### AWS E2C

```shell
$ cd myvenv
$ source bin/activate
(myvenv)$ pip install Django
(myvenv)$ python3
>>import django
>>django.VERSION
(2, 0, 7, 'final', 0)
```



### Mac

```shell
$ cd myenv
$ source bin/activate
(myenv)$ pip install Django
(myenv)$ python3
>>import django
>>django.VERSION
(2, 0, 7, 'final', 0)
```



## OpenCV 설치



### Mac

```shell
$ cd myenv
$ source bin/activate
(myenv)$ pip install OpenCV-Python
(myenv)$ python3
>>cv2.__version__
'3.4.2'
```





## Tensor-flow 설치



### Mac

```shell
$ cd myenv
$ source bin/activate
(myenv)$ pip3 install --upgrade tensorflow
(myenv)$ python3
>>> import tensorflow
>>> tensorflow.VERSION
'1.9.0'
```











## SCP Usage







## pyenv 다시 설치



```shell
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev


```





### 참고 

[텐서플로우 번역 깃북](https://tensorflowkorea.gitbooks.io/tensorflow-kr/content/) 에 MNIST, Tensor-flow 에 대한 자세한 설명이 나온다  --- 감사합니다.

[Django 번역 깃북](https://tutorial.djangogirls.org/ko/)

