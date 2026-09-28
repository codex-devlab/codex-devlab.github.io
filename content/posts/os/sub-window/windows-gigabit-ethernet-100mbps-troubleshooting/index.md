---
title: "[Windows] 기가비트 랜인데 100Mbps로 잡히는 문제 - 드라이버부터 공유기까지 추적기"
date: 2026-09-28T21:50:00+09:00
description: Docker/WSL 통합 이후 갑자기 1Gbps 이더넷이 100Mbps로 떨어진 문제를 드라이버 업데이트, 어댑터 리셋, 이벤트 로그 분석까지 거쳐 진짜 원인(공유기 포트)을 찾아낸 트러블슈팅 기록
menu:
  sidebar:
    name: "[Windows] 기가비트 랜 100Mbps 저하 트러블슈팅"
    identifier: windows-gigabit-ethernet-100mbps-troubleshooting
    parent: sub-window
    weight: 30
tags:
- Windows
- Network
- Troubleshooting
- Realtek
- Docker
- WSL
- Tailscale
---

## 시작: 분명 기가비트인데 왜 100Mbps지?

어느 날 갑자기 체감 인터넷 속도가 느려졌다는 걸 느꼈습니다. 최근에 한 일이라곤 **Docker Desktop을 켜고 WSL 통합을 활성화**한 것뿐인데, 이더넷 어댑터를 확인해보니:

```powershell
Get-NetAdapter | Select-Object Name, InterfaceDescription, Status, LinkSpeed
```

```
Name  InterfaceDescription                Status  LinkSpeed
----  --------------------                ------  ---------
이더넷  Realtek PCIe GbE Family Controller  Up      100 Mbps
```

분명 기가비트(1Gbps) 회선이고 지금까지 잘 쓰던 랜인데, 링크 속도가 **100Mbps로 뚝 떨어져** 있었습니다. 타이밍상 Docker/WSL 때문일 거라 의심하며 추적을 시작했습니다.

---

## 1단계: 드라이버부터 의심하기

가장 먼저 확인한 건 NIC 드라이버였습니다.

```powershell
Get-WmiObject Win32_PnPSignedDriver | Where-Object {$_.DeviceName -like "*Realtek*"} |
  Select-Object DeviceName, DriverVersion, DriverDate
```

확인해보니 드라이버가 **2017년에 배포된 v1.0.0.14** 버전으로, 거의 방치된 수준으로 오래된 드라이버였습니다. 메인보드는 ASUS TUF B450M-PRO GAMING, 칩셋은 Realtek RTL8168(RTL8111H) 계열이었고, ASUS 공식 지원 페이지에서 최신 드라이버(v1168.27.50.919, 2025-09-19 배포)를 찾아 다운로드 후 설치했습니다.

> ASUS 지원 페이지는 JavaScript 렌더링 방식이라 자동으로 다운로드 URL을 추출할 수 없었고, 결국 브라우저로 직접 받아야 했습니다. 설치 파일은 InstallShield 기반의 `AsusSetup.exe` 래퍼를 사용합니다.

드라이버 설치 후 재부팅까지 했지만...

```powershell
Get-NetAdapter -Name "이더넷" | Select-Object Name, Status, LinkSpeed
```

```
Name  Status  LinkSpeed
----  ------  ---------
이더넷  Up      100 Mbps
```

**여전히 100Mbps.** 드라이버는 최신 버전으로 정상 설치되어 재부팅 후에도 유지되는 걸 확인했는데도 속도는 그대로였습니다.

---

## 2단계: 설정과 로그를 뒤지다

드라이버가 원인이 아니라면 남은 용의자는 셋 중 하나입니다.

1. Speed & Duplex 설정이 강제로 100Mbps에 고정되어 있는 경우
2. NIC 자체의 하드웨어 오류
3. Docker/WSL이 만든 가상 네트워크 스위치가 물리 어댑터에 개입하는 경우

하나씩 지워나갔습니다.

**속도/이중 설정 확인**

```powershell
Get-NetAdapter -Name "이더넷" | Get-NetAdapterAdvancedProperty |
  Format-Table DisplayName, DisplayValue -AutoSize
```

`속도 및 이중` 항목은 `자동 교섭`(Auto Negotiation)으로 정상 설정되어 있었습니다. → 원인 아님

**이벤트 로그 확인**

```powershell
Get-WinEvent -LogName System -MaxEvents 300 |
  Where-Object {$_.Message -match "Ethernet|Realtek|NIC|link"}
```

하드웨어 오류나 링크 플래핑 관련 에러는 없었습니다. → 원인 아님

**Hyper-V 가상 스위치 바인딩 확인**

Docker Desktop의 WSL 통합이 외부 가상 스위치를 물리 NIC에 바인딩해서 협상을 방해할 수 있다는 가설을 세우고 확인했습니다.

```powershell
Get-VMSwitch | Select-Object Name, SwitchType, NetAdapterInterfaceDescription
```

결과는 **비어 있음** — 물리 어댑터에 바인딩된 Hyper-V 외부 스위치가 없었습니다. Docker/WSL은 내부(NAT) 스위치만 쓰고 있어서 이 경로도 원인이 아니었습니다.

어댑터를 껐다 켜는 것(disable/enable), 전체 시스템 재부팅까지 다 해봤지만 100Mbps는 요지부동이었습니다.

---

## 3단계: 진짜 범인 — 공유기

소프트웨어/드라이버 쪽에서 할 수 있는 조치를 다 해봤는데도 안 풀린다는 건, 협상이 **물리 계층(케이블 또는 공유기 포트)**에서 막히고 있다는 뜻이었습니다.

- 기가비트(1000BASE-T)는 케이블의 **4쌍 전선을 모두** 사용합니다.
- 100BASE-TX는 **2쌍만** 사용합니다.
- 케이블이나 반대편 포트에 문제가 있으면, 통신 자체는 되지만 속도는 안전한 100Mbps로 "폴백"됩니다.

케이블 교체 전에 먼저 **공유기를 재부팅**해봤습니다. 그리고—

```powershell
Get-NetAdapter -Name "이더넷" | Select-Object Name, Status, LinkSpeed
```

```
Name  Status  LinkSpeed
----  ------  ---------
이더넷  Up      1 Gbps
```

**바로 복구됐습니다.** 결국 원인은 PC도, 드라이버도 아니라 **공유기 포트가 100Mbps로 저하된 채 고착돼 있었던 것**이었습니다.

---

## 예상치 못한 후폭풍: Tailscale 크래시 루프

문제를 해결하고 나니 이번엔 **Tailscale 서비스가 계속 재시작**되는 게 눈에 띄었습니다.

```powershell
Get-WinEvent -LogName System -MaxEvents 2000 | Where-Object {$_.Message -match "Tailscale"}
```

```
Error  The Tailscale service terminated unexpectedly. It has done this 3 time(s).
```

`tailscaled.exe`의 자체 로그를 열어보니 원인이 명확했습니다.

```
control: bootstrapDNS(...) error: dial tcp ...: connectex: A socket operation was
  attempted to an unreachable network.
health(warnable=no-derp-connection): error: Tailscale could not connect to the
  'Tokyo' relay server. Your Internet connection might be down...
```

네트워크가 끊겨 있던 몇 분(공유기 재부팅 구간) 동안 Tailscale이 컨트롤 서버/DERP 릴레이에 계속 연결을 시도하다 실패했고, **네트워크가 복구되는 바로 그 과도기(어댑터 재협상 + IP 재획득 + DNS 재등록이 동시에 발생하는 순간)**에 서비스가 연달아 3번 죽으면서 Windows의 기본 복구 횟수를 소진하고 완전히 멈춰버린 것으로 보입니다.

이 부분은 서비스를 강제로 재시작하기보다, **재발하는지 지켜보며 원인을 더 좁혀보는 중**입니다.

---

## 정리

| 단계 | 의심한 원인 | 실제 결과 |
|------|------------|-----------|
| 1 | 오래된 NIC 드라이버(2017년) | 최신화했지만 문제 지속 |
| 2 | Speed/Duplex 강제 설정 | 정상(Auto)이라 원인 아님 |
| 3 | Hyper-V 가상 스위치 바인딩 | 바인딩 없음, 원인 아님 |
| 4 | **공유기 포트 협상 고착** | ✅ 재부팅으로 즉시 해결 |
| 5 (부수효과) | Tailscale 서비스 크래시 | 네트워크 복구 과도기에 3연속 다운 |

**교훈**: 링크 속도 저하 같은 증상은 반사적으로 "드라이버 문제겠지"로 단정하기 쉽지만, 드라이버/OS 쪽 조치를 다 해봐도 안 풀린다면 **케이블과 반대편 장비(공유기/스위치)까지 의심 범위를 넓혀야** 합니다. 특히 오토 네고시에이션은 양쪽이 합의해야 하는 과정이라, 한쪽만 아무리 만져봐야 답이 안 나올 수 있습니다.
