---
title: Ubuntu & OSX setting
date: 2018-06-01T09:12:43+05:00
description: Ubuntu & OSX 간단한 기본 설정. 해당 문서는 예전 markdown inline link 방식으로 작성됨.
menu:
  sidebar:
    name: Ubuntu & OSX setting
    identifier: ubuntu-macos-setting
    parent: sub-debain-based
    weight: 20
tags:
- OS
- Ubuntu
- 초기설정
- Git
- Vim
- Airline
- Autojump
---

- [root](#root)
- [Fire Fox Update](#fire-fox-update)
- [GIT Installation and Setting](#git-installation-and-setting)
- [Git multi user ssh setting](#git-multi-user-ssh-setting)
- [Autojump Installation](#autojump-installation)
- [vim Installation and Setting](#vim-installation-and-setting)
  - [vim scheme](#vim-scheme)
  - [vim Plugin Install](#vim-plugin-install)
  - [youcompleteme](#youcompleteme)
  - [Airline](#airline)
  - [ctag](#ctag)
- [Mouse setting](#mouse-setting)



root
---

```
$sudo passwd root
```



Fire Fox Update
---

```shell
$sudo apt-get firefox
$sudo apt-get update
```



GIT Installation and Setting
---

```shell
설치
$sudo apt install git

초기 설정
$git config --global user.name "kimleepark"
$git config --global user.email kimleepark@gmail
//$git config -l

$ssh-keygen 
//.ssh 폴더안에 id_rsa.pub 의 내용을 Github ssh에 등록해준다.
$git init
$git log
//git 작업 기록
$git status
//git 현재 현황(add 되거나, 추적 가능한 파일 현황)
$git add
//-u 업데이트된 항목을 추적해서 add함,  --all,-A 폴더내 모든 항목을 add함
$git commit
$git push
//local -> remote 저장소로 이동
$git pull
//원격 저장소에 있는 변경 사항을 가져와서 merge함

```

>[Git 시작하기](https://git-scm.com/book/ko/v1/%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0-Git-%EC%B5%9C%EC%B4%88-%EC%84%A4%EC%A0%95) 를 참고 하시면서 작업 하시면 좋습니다.

>.gitignore 에 a.out, *.o, *.txt 등 을 추가하여 불필요한 형식은 걸러서 올리는것이 작업하기 편합니다.

>push 할때마다 아이디와 비밀번호 요구
>일단 이유를 알아야 하니 [여기](https://help.github.com/articles/why-is-git-always-asking-for-my-password/)참고해 주세요.
>[ssh key 생성부터 설정](https://help.github.com/articles/connecting-to-github-with-ssh/)
```shell
>$ls -al ~/.ssh
>//기존에 키가 존재 하는지 체크해 주세요. 아마 대부분 이미 ssh-keygen으로 만드셨을겁니다.
>$ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
>//이후 나오는 설정 "아~ 잘모르궤쎠 엔터 누르롸눈거 가튠뒈 잘 모르게쒀 걍 무조건 엔터"
>//뭐 순서대로 저장할 폴더, 패러프레이즈 에 대한 방식이니 그냥 엔터 눌러주세요.
>$cat ~/.ssh/id_rsa.pub
>//전부 복사해서 github sshkey 에 등록해주세요
>//등록후 조금 시간이 지나야 인증이 되니까 그동안 reboot해주세요
>$ssh -T git@github.com
>//Hi~~어쩌구 나오면 ssh에 등록되고 연결이 된거에요.
```

>그리고 대부분 아마 push할때 마다 id 와 pass를 물어보는 경우는 git clone시에 ssh가 아닌 http로 clone을 해서 그렇습니다.
>그냥 간단하게 원래있던 폴더 삭제후
>clone할때에 ssh로 clone하시면 id&pass 안물어봄.


```shell
기존 로컬 저장소와 원격 저장소 연결
1.원격 저장소를 먼저 만들고 그냥 Clon
$git clone https://원격저장소.git

2.기존로컬 저장소를 원격저장소와 연결
Github에서 resipotory를 먼저 만들어야 한다.
$mkdir "resipotory와 같은 이름"
//resipotory 이름은 foo라고 가정한다.
$cd foo
$git init
//빈저장소를 만드는것
$git remote <name> <https://원격저장소.git>
//name 간단하게 push할때마다 사용하는 브랜치 이름이다.
$git remote show <name>
//분명 HEAD 브랜치 : (unknown) 이라고 나올것이다. 
$git push <name> master
```

Git multi user ssh setting
---

>현재 사용하는 Git 계정이 두개입니다. 뭔가 생각에는 계정이 두개 있어도 한번 만들어져 있는  
>ssh key를 사용해도 될것 같지만, 이미 사용한 ssh key를 다른 계정에 등록하려고 하면  
>`key is already used.`라고 나옴니다. 때문에 추가 계정을 위한 ssh key가 필요합니다.  
>먼저 .ssh 폴더안의 파일을 보면 이해가 빠릅니다.
```shell
$cd ~/.ssh
.
├── config -> 여러개정을 연결하기 위한 cofing
├── id_rsa
├── id_rsa.pub -> 원래 계정의 ssh key
├── id_rsa_blog
└── id_rsa_blog.pub -> 추가 계정의 ssh key
```
>일단 추가 계정을 위한 ssh key를 생성해야 합니다.  
```shell
$ssh-keygen -t rsa -C "username@gmail.com" //새 계정의 이메일 주소
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/Edwardson/.ssh/id_rsa): 
id_rsa_project   //project는 임의로 작명해 주세요.
...

$ssh-add ~/.ssh/id_rsa_project    
//ssh key 추가
$ssh-add -l                       
//ssh key 저장
$vi config
//이제 ssh가 두개가 됬으니 각각 생성된 key로 동작하도록 연결해줘야 합니다.
//cofig를 .ssh안에 만들어줘서 다음 내용을 추가해 주세요.
# default account
Host github.com
HostName github.com
User git
IdentityFile ~/.ssh/id_rsa

# project account
Host github.com-project
HostName github.com
User git
IdentityFile ~/.ssh/id_rsa_project

$ssh -T git@github.com
Hi "원래계정 이름 나옴"! You've successfully authenticated, but GitHub does not provide shell access.
$ssh -T git@github.com-project
Hi "추가계정 이름 나옴"! You've successfully authenticated, but GitHub does not provide shell access.
//위에 처럼 확인 됬으면 새로운 git계정에 ssh를 연결해서 사용할 준비가 다됬습니다.
//이제 이전에 했던 Git hub에 ssh 새로 생성한 키를 등록해 주세요.
```
>자 이제 거의 다됬습니다. 추가 계정의 repository만 remote 해주면 되겠네요.  
```shell
$mkdir project && cd project
$git init
$git config user.name project
$git config user.email project@email.com
$git remote add origin git@github.com-project:YOURNAME/REPOSITORY.git
//아까 config 에서 설정했던 두번째 계정의 Host 가 github.com-project 였죠
//그래서 remote 로 연결해 줄때도 git@github.com-project로 연결해줘야 합니다.
$echo "project" >> readme.md
$git add -A
$git commit -m "firstcommit"
$git push -u origin master
```






Autojump Installation
---

```shell
$sudo apt-get install autojump
//Ubuntu에는 패키지가 있어서 apt-get으로 설치 가능
$sudo apt-get update
$autojump
//분명 이부분에서 bach 설정이 안되어 있어서 추가로 작성해달라고 나옵니다.
$echo ". /usr/share/autojump/autojump.bash" >> ~/.bashrc
//autojump가 터미널 실행시 바로 작동 할수 있게 경로를 추가해 줘야 한다.
```

> [Autojump](https://github.com/wting/autojump) 를 참고하시길 바랍니다.
> 사실 요즘은 너무 간결하게 설치파일이 작성되어 있어서.  
> 그냥 install.py만 실행해주면 끝입니다...ㅠㅠ









vim Installation and Setting
---

```shell
설치
$sudo apt-get vim
$sudo apt-get update
vim scheme
```
>후...여러가지 준비해봤습니다. 제대로 모시겠습니다.[Vim 설정](./vim/Mac_vim_setting)

### vim scheme

> 여러가지 테마는 [http://vimcolors.com](http://vimcolors.com/)여기에 많습니다.
> 테마가 들어가야할 위치는
> /usr/share/vim/vimXX/colors
> 여기에 있습니다. vimXX는 Vim마다 버전이 다르기 때문에 본인에게 맞는 버전을 찾아 주면 될것 같네요.

```c
$sudo wget -O /usr/share/vim/vim74/colors/molokai.vim https://raw.github.com/tomasr/molokai/master/colors/molokai.vim
//이런식으로 원하는 테마를 찾아서 바로 넣어주면 됩니다.
설정은 
$vi ~/.vimrc
colorscheme molokai
이렇게 넣어주면 되겠네요.
```

### vim Plugin Install

> 우선은 번들을 설치해 볼까요? 자세한 사항은 [여기](https://github.com/VundleVim/Vundle.vim#inspiration--ideas)를 참고해 주세요

```c
$git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
$vi ~/.vimrc
```

```c
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
 
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

```

### youcompleteme

>자동 완성 플러그인 입니다. 자세한건 [여기](https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64)를 참고해 주세요

```c
$vi ~/.vimrc
Plugin 'Valloric/YouCompleteMe'
//위 내용 추가후 :PluginInstall


$ sudo apt-get install build-essential cmake
$ sudo apt-get install python-dev python3-dev
$ cd ~/.vim/bundle/YouCompleteMe
$ ./install.py --clang-completer
//youcompleteme 에서 특정 언어에 대한 자동완성을 지원하기 위해 각 언어의 지원을 받아야한다.
//여기서 C 언어에 대해 지원하고 싶으면 ./install.py 할때 --clang-completer를 추가해 준다.
//귀찬으면 그냥 -all

```

> 간혹 문제가 생길수 있다. vim에서 ycm_extra_conf.py이게 없다고 에러를 토해낼때!!
> [여기](https://github.com/rdnetto/YCM-Generator)를 참고해도 되고
> 다음 처럼 해줘도 된다.
> let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py' 추가
> cd ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm
> vim .ycm_extra_conf.py
> 여기서 compilation_database_folder = ''를 찾아 ''부분에
> '~/.vim/' 로 고친다.

> YCM Option
> .vimrc에 추가
> "" turn on completion in comments
> let g:ycm_complete_in_comments=1
> "" load ycm conf by default
> let g:ycm_confirm_extra_conf=0
> "" turn on tag completion
> let g:ycm_collect_identifiers_from_tags_files=1
> "" only show completion as a list instead of a sub-window
> set completeopt-=preview
> "" start completion from the first character
> let g:ycm_min_num_of_chars_for_completion=1
> "" don't cache completion items
> let g:ycm_cache_omnifunc=0
> "" complete syntax keywords
> let g:ycm_seed_identifiers_with_syntax=1


### Airline

> 자세한건 [여기](https://github.com/vim-airline/vim-airline)를 참고해 주세요.
> 각종 정보들을 vim에 표시되게 합니다. 버퍼를 사용해 창을 나눌수도 있고 다른 플러그인에 같이 적용도 됩니다.(솔직히 그냥 간지)

```bash
$vi ~/.vimrc
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
:PluginInstall
```

> 테마 적용 [여기](https://github.com/vim-airline/vim-airline-themes)에서 원하는 테마를 찾고 밑에 처럼 적용해주면 됩니다.
> :AirlineTheme <theme>



### ctag

> 커널 프로그래밍 을 위해서 필수 절차이다.[여기](https://courses.cs.washington.edu/courses/cse451/10au/tutorials/tutorial_ctags.html)에 ctags에 대한 명령어등 튜토리얼이 있다.

```bash
$sudo apt-get install exuberant-ctags

$vi ~/.vimrc
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
//vim-misc는 easytags설치후 에러를 토하면서 misc 설치하라 하면 추가해주면됨
```

>기본 사용법
>Ctrl + ] - 함수, 구조체가 정의되어있는 곳으로 이동.
>Ctrl + t - 이동하기 전 소스코드 위치로 옴.



Mouse setting
---
```shell
시스템 설정 -> 마우스 설정 에 마우스 속도 조절이 없다....
1. rc.local에 스크립트 파일 등록 [적용안됨]
  
2. init.d에 스크립트 파일 등록 [적용안됨]
  Runlevel=5	

#1~2번 까지 systemctl 로 상태를 확인해본 결과 똑같은 오류 메세지 나옴
unable to open display "" 이런식임
방법을 찾다가 display가 뜻하는것은 서버등 내 서버에 접속된 사용자들의 display 같음 하지만 난 솔플을 하는중이니
$echo $DIPLAY
:0
일케 나옴 그러니당연히 매번 unable~ 이런식으로 오류를 던져줌
[해결]
  export XAUTHORITY=/home/codex/.Xauthority
  sh & xset -display :0 m 1/2 1/2
  현재 내 display에 대한 정보와 권한을 가져오는것이 방법이였다.
  근데 중요한건 결국 안됨....rc.local의 실행과정을 보니 parent에서 fork하는것이였고 현재 쉘에는 적용 안됨...

3.autostart에 스크립트 등록 [적용안됨]

4.autostart에 mate-mouse-property [적용됨]
  근데 부팅되자마자 앱 화면이 로드됨
5. 런치패드 업데이트 [안됨]
6. 우분투 업데이트 [안됨]
7. Gnome으로 변경후 업데이트 [됨]
```