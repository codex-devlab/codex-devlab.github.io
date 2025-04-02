---
title: "[DevOps] Terraform vs Ansible 뭐가 다르죠?"
date: 2025-03-28T08:06:25+06:00
description: Terraform vs Ansible 비교 
menu:
  sidebar:
    name: "[DevOps] Terraform vs Ansible 뭐가 다르죠?"
    identifier: difference_of_terraform_and_ansible
    parent: sub-devops
    weight: 20
tags:
- Terrafrom
- Ansible
- IaC
- 비교분석
---




## Terraform vs Ansible: 기술적으로 완벽 정리한 차이점 비교 분석


클라우드와 DevOps 분야에서 인프라 자동화는 필수입니다. 대표적인 IaC(Infrastructure as Code) 도구로 Terraform과 Ansible이 있는데요, 두 도구는 비슷해 보이지만 명확한 차이점이 있습니다. 이번 포스팅에서는 두 도구를 기술적인 관점에서 상세히 비교하고, 명확한 예시를 통해 각각 언제 사용하는 것이 효과적인지 설명하겠습니다.


---



### Terraform과 Ansible의 개념적 차이

| 항목             | Terraform                       | Ansible                            |
|-----------------|----------------------------------|-------------------------------------|
| 목적             | 인프라 리소스 프로비저닝 및 상태 관리 | 서버 구성 관리, 애플리케이션 배포 및 자동화 |
| 지향 방식        | 선언적(Declarative)               | 절차적(Procedural), 일부 선언적 방식    |
| 상태 관리        | 상태 파일(.tfstate) 유지            | 상태 파일 없이 실행마다 실시간 체크    |
| 멱등성(Idempotency) | 기본적으로 제공                     | 모듈 수준에서 제공, 상황에 따라 달라짐  |

- **Terraform**은 주로 클라우드 기반 인프라의 전체 생명주기를 관리하는 데 효과적입니다.
- **Ansible**은 서버의 세부 구성 및 애플리케이션의 배포, 관리 자동화에 더 적합합니다.


---




### 기술적 실행 방식 비교

| 항목                 | Terraform                                | Ansible                        |
|---------------------|-------------------------------------------|---------------------------------|
| 사용 언어            | HCL(HashiCorp Configuration Language)      | YAML + Jinja2                    |
| 실행 방식            | Provider 기반 API 호출                      | SSH/WinRM 원격 명령 실행          |
| 에이전트(Agent) 여부  | 불필요                                      | 불필요(Agentless)                |

Terraform은 클라우드 제공자의 API와 직접 상호작용하며, Ansible은 SSH 또는 WinRM을 통해 서버에 직접 접속하여 구성 작업을 수행합니다.  
하지만 Terraform은 On-Prem 환경에서 클라우드 서버를 다루는건 적절한 Provider가 있다면 문제없지만, 어플리케이션을 베포하기 위한 설정 부터 패키지 설치를 수행해야 한다면 Ansible 처럼 SSH로 접속 해야 합니다.


---

### 상태 관리 방식의 차이

Terraform은 `.tfstate` 파일로 인프라 상태를 정확히 관리합니다. 반면 Ansible은 별도의 상태 파일 없이 매 실행 시 원격 시스템의 상태를 직접 조회하여 확인합니다.

<details>
  <summary>예시: Terraform 상태 파일 관리</summary>
  
#### 예시: Terraform 상태 파일 관리

```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "state/terraform.tfstate"
    region = "us-west-2"
  }
}
```
</details>

<details>
  <summary>예시: Ansible 상태 관리</summary>
  
#### 예시: Ansible 상태 관리
```yaml
- name: Ensure Nginx is installed
  apt:
    name: nginx
    state: present
```
</details>

---

### 명확한 활용 예시와 차이점

<details>
  <summary>Terraform 예시: AWS EC2 인스턴스 생성</summary>

#### Terraform 예시: AWS EC2 인스턴스 생성

```hcl
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "WebServer"
  }
}
```
</details>


<details>
  <summary>Ansible 예시: 서버 환경 구성</summary>

#### Ansible 예시: 서버 환경 구성

```yaml
- name: Configure Nginx web server
  hosts: webservers
  become: yes

  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: latest

    - name: Start and enable Nginx service
      service:
        name: nginx
        state: started
        enabled: yes
```

위 예시에서 Terraform은 인프라 자체의 생성과 삭제를 관리하고 있으며, Ansible은 이미 프로비저닝된 서버의 세부 구성을 관리하고 있습니다.
</details>

---

### 적절한 사용법

Terraform과 Ansible은 서로 보완적인 관계입니다. 다음과 같은 방식으로 병행 사용하는 것이 모범 사례입니다.

- Terraform: 클라우드 환경의 전체 인프라 구축과 리소스의 상태 관리
- Ansible: 프로비저닝된 인프라 내의 애플리케이션 설치, 서버 구성, 환경 설정 자동화

앞으로의 Tech 포스팅에서는 이 두 도구를 더 심도 있게 다뤄보고, 실제 현업에서 발생하는 다양한 케이스를 중심으로 비교 분석할 예정입니다.

계속해서 Terraform, Ansible 및 다양한 DevOps 도구에 대한 최신 정보와 팁을 전해 드리겠습니다.

---

