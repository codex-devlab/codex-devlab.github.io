---
title: Git Manual
date: 2018-05-18T08:12:43+05:00
description:
menu:
  sidebar:
    name: Git Manual
    identifier: git-manual
    parent: dev
    weight: 50
tags:
- Git
- Github
- Manual
---


### Pre-commit

> Pre Commit의 동작은 Commit이 이루어지는 시점에 Commit이 완료 되기전에 해당 스크립트가 실행되는 방식입니다.  
> `$ git init` 혹은 저장소를 Clone받게 되면 경로에 `.git/hooks`  
> 내부에 다양한 Hook이 있는걸 확인 할 수 있습니다.  


Pre Commit을 사용하는 두 가지 방법이 있습니다.
상세하게 따져본다면 git hook을 사용하는것은 동일하나,  
이를 관리하는 방법이 조금 상이합니다.

Pre Commit을 사용하는 이유는 몇가지가 있지만,  
가장 큰 목적은 동료와의 협업, Commit 관리, 오류 방지 등이 있다고 생각합니다.  

예를 들어 Lint, Syntex Error 등이 해당 될 듯 합니다.

 

그렇다면 동료 모두가 같은 Pre Commit을 사용하기 위해선 어떻게 해야 할까요?  
Github에 공유되어서 같은 룰을 공유 받는게 가장 편한 방법이라 생각합니다.  

그럼 먼저 Pre Commit을 Local 환경에서 생성하고 사용하는 방법 부터 설명드리고 이를 공유해서 편리하게 사용하는 방법 까지 발전시켜 보겠습니다.  

#### Pre-Commit Running on Local

예를 들어보겠습니다.
Go언어로 개발중에 go 모듈의 오류나 경로가 정상적으로 설정 되어 있는지 확인하는 Pre commit을 실행한다고 가정 하겠습니다.  

로컬 환경에서 각 모듈을 개발하고 모듈의 경로를 로컬 경로로 지정 한 채, 커밋이 되게 된다면 다른 팀원이나 배포되는 서버에서 실행  시 문제가 발생 할 수 있기 때문에 사전에 방지하는것이 좋습니다.  

그럼 이를 방지 할 수 있는 pre commit을 생성해 보도록 하겠습니다.

> pre-commit은 반드시 `.git/hooks/pre-commit` 의 이름으로 있어야 합니다.  

<details>
  <summary>pre-commit 예제</summary>

1. `.git/hooks/pre-commit` 을 생성 합니다.
   ```shell
	$ vim .git/hooks/pre-commit
	#!/bin/bash

	# Git 프로젝트 루트 경로 가져오기
	GIT_ROOT=$(git rev-parse --show-toplevel)
	GO_MOD_FILE="$GIT_ROOT/go.mod"

	# 1️⃣ go.mod 파일이 없으면 커밋 중단
	if [ ! -f "$GO_MOD_FILE" ]; then
		echo "❌ go.mod 파일이 없습니다. 커밋을 중단합니다!"
		exit 1
	fi

	# 2️⃣ go.mod 파일에 특정 문자열이 없으면 커밋 중단
	if ! grep -q "github.com/hugo-toha/toha/v4" "$GO_MOD_FILE"; then
		echo "❌ go.mod 파일에 필요한 패턴이 없습니다. 커밋을 중단합니다!"
		exit 1
	fi

	echo "✅ pre-commit 훅이 성공적으로 실행되었습니다."
	exit 0  # 정상 종료

	```  

2.  pre-commit 실행 권한 부여
   ```shell
   $ chmod +x .git/hooks/pre-commit
   ```  

3.  pre-commit 실행 확인
   ```shell
   $ git commit --allow-empty -m "Test Pre-Commit"
   echo "✅ pre-commit 훅이 성공적으로 실행되었습니다."
   ```

정상적으로 실행되는지 확인 할 목적이라면 단순히 pre-commit을 실행해봐도 됩니다!

</details> 




#### Convenient sharing method of Pre-Commit

이제 pre-commit을 협업하는 모두가 공유해서 사용하는 두 가지 방법에 대해 설명 드리겠습니다.

<details>
  <summary>`.githooks/` 디렉터리를 사용하여 공유</summary>

##### Using `.githooks/` dir
1. GitHub 저장소에 githooks/pre-commit 스크립트 저장
   프로젝트 루트에 .githooks/pre-commit 파일을 추가합니다.

	```shell
	$ mkdir -p .githooks
	$ touch .githooks/pre-commit
	$ chmod +x .githooks/pre-commit
	```

	그리고 pre-commit 훅을 .githooks/pre-commit에 작성합니다.  

	```shell
	#!/bin/bash

	echo "🔍 Pre-commit hook is running..."

	# 예제: go.mod 파일이 없으면 커밋 중단
	if [ ! -f "go.mod" ]; then
		echo "❌ go.mod 파일이 없습니다. 커밋을 중단합니다!"
		exit 1
	fi

	echo "✅ Pre-commit check passed!"
	exit 0
	```

2. 개발자가 .git/hooks/에 자동으로 적용
	로컬에서 git clone한 후, 아래 명령어를 실행하면 .git/hooks/pre-commit에 자동으로 적용됩니다.  

	```shell
	$ git config core.hooksPath .githooks
	```
	이렇게 설정하면, git commit을 실행할 때 `.githooks/pre-commit`이 실행됩니다.


</details>  

<details>
  <summary>python `pre-commit` 프레임워크 사용</summary>

##### Using `pre-commit` Framework
[pre-commit](https://pre-commit.com/) 프레임워크를 활용하면, 저장소에 `.pre-commit-config.yaml` 파일을 추가하는 것만으로도 팀 전체가 동일한 pre-commit 훅을 사용할 수 있습니다.


1. pre-commit 설치
	개발자는 먼저 pre-commit을 설치해야 합니다.

	```shell
	pip install pre-commit  # Python이 설치된 경우
	```

2. .pre-commit-config.yaml 파일을 저장소에 추가
	저장소 루트에 .pre-commit-config.yaml 파일을 추가합니다.

	```yaml
	repos:
	- repo: local
		hooks:
		- id: go-mod-check
			name: Go Mod Check
			entry: bash scripts/pre-commit.sh
			language: system
			types: [text]
	```

3. pre-commit 실행 스크립트 추가
	저장소 내 scripts/pre-commit.sh 파일을 만들어 아래 내용을 작성합니다.

	```shell
	#!/bin/bash

	echo "🔍 Pre-commit hook is running..."

	# go.mod 파일 체크
	if [ ! -f "go.mod" ]; then
		echo "❌ go.mod 파일이 없습니다. 커밋을 중단합니다!"
		exit 1
	fi

	echo "✅ Pre-commit check passed!"
	exit 0
	```
4. 개발자가 pre-commit install 실행
	```shell
	$ pre-commit install
	```
이제 git commit을 실행할 때마다 pre-commit이 자동으로 실행됩니다.

</details>  