---
title: "[Windows] 기가비트 랜인데 100Mbps로 잡히는 문제 - 드라이버부터 공유기까지 추적기"
date: 2026-09-28T21:50:00+09:00
description: Docker/WSL 통합 이후 갑자기 1Gbps 이더넷이 100Mbps로 떨어진 문제를 드라이버 업데이트, 어댑터 리셋, 이벤트 로그 분석으로 추적하고, 공유기 오진 끝에 벽 매립 랜선 끝 RJ45 커넥터 접촉 불량이 진짜 원인이었음을 정정한 트러블슈팅 기록
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
- RJ45
---

> **2026-10-07 정정**: 이 글을 처음 올렸을 때는 원인을 **공유기 포트**로 결론 내렸지만 **오진**이었습니다. 이후 같은 증상이 재발했고, 추적 끝에 **벽 매립 랜선 끝의 RJ45 커넥터 접촉 불량**이 원인이었음을 확인했습니다. 자세한 내용은 아래 [후속](#후속-진짜-원인은-벽-매립-랜선-끝의-rj45-커넥터였다) 섹션을 참고하세요.

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

## 3단계: 범인은 공유기? (이후 오진으로 정정)

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

> **정정**: 이 결론은 틀렸습니다. 이후 링크가 다시 100Mbps로 떨어지고 게임 중 끊김까지 생겼습니다. 공유기 재부팅은 링크를 재협상시켜 **일시적으로** 기가비트가 잡히게 했을 뿐인 것으로 보이고, 실제 원인은 아래 후속 섹션의 접촉 불량이었습니다.

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

## 후속: 진짜 원인은 벽 매립 랜선 끝의 RJ45 커넥터였다

공유기를 재부팅해서 해결됐다고 생각했는데, 얼마 지나지 않아 **게임(LoL)과 원격 접속 세션이 수시로 끊기기** 시작했습니다. 링크 속도도 어느 시점부터 다시 100Mbps로 잡혀 있었습니다.

### 소프트웨어부터 의심했지만

처음에는 Docker/WSL이 만든 Hyper-V 브리지가 물리 어댑터를 주기적으로 멈추는 것으로 의심해서 WSL을 `networkingMode=mirrored`로 바꾸고, NIC 절전 옵션과 PCIe ASPM도 껐습니다. 부분적으로 나아졌을 뿐, 끊김은 계속됐습니다.

### 공유기와 회선은 아니었다

같은 시간대에 **휴대폰(WiFi)과 PC(유선)에서 동시에 핑**을 보냈더니 PC만 끊기고 휴대폰은 한 번도 끊기지 않았습니다. 공유기와 회선은 정상이고, 문제는 PC의 유선 경로 안에 있다는 뜻이었습니다.

### 결정적 증거: 커넥터를 흔들어 보니

0.3초 간격으로 연속 핑을 보내는 중에 PC 쪽 커넥터를 손으로 흔들었습니다. 평소 5~7초 간격으로 한 번씩 나던 손실이 **흔드는 구간에만 3.4초, 4.9초짜리 연속 손실**로 크게 악화됐습니다. 랜 포트를 공유기의 다른 포트로 옮겨도 똑같이 재현돼서, **공유기 포트 문제가 아니라 케이블 끝의 물리적 접촉 불량**으로 판단했습니다. 겉으로 봐서는 커넥터가 멀쩡해 보여도, 내부 접점이 불량이면 이렇게 재현됩니다.

### 구조상 패치케이블을 못 바꾸는 상황

벽면 소켓(월 잭)이 없고, 벽 속에서 나온 랜선 끝의 RJ45 커넥터가 그대로 PC에 꽂혀 있는 구조였습니다. 그래서 패치케이블만 바꿔 끼워 보는 방법이 통하지 않았습니다. 대신 **벽에서 나오는 선 끝의 RJ45 커넥터를 새것으로 교체**했습니다.

### 교체 후 결과

모니터링 로그(15초 간격으로 게이트웨이/외부/DNS를 확인해 실패한 줄을 기록)로 비교한 결과입니다.

| 구간 | 결과 |
|------|------|
| 교체 전 (9/30) | 기록된 121줄 중 **49줄이 실패** |
| 교체 직후 3분 테스트 | 손실이 24건 남아 있음 |
| 교체 후 약 3일 (10/4 12:50 이후 ~ 10/7) | 실패 **8줄**(부팅 직후 1건 포함) |
| 1초 간격 핑 모니터 (10/7) | 시간별 게이트웨이 손실 **0** |

교체 직후 테스트에서는 손실이 남아 있었지만, 이후 로그에서는 끊김이 크게 줄었고 유선 구간의 연속 손실도 더 이상 잡히지 않았습니다. 따라서 **원인은 벽 매립 랜선 끝 RJ45 커넥터의 접촉 불량**이었다고 판단합니다.

### 아직 남은 것

링크 속도는 **여전히 100Mbps**입니다. 접촉 불량은 잡았지만, 8가닥 중 일부가 제대로 결선되지 않았거나 케이블 등급 문제일 수 있습니다. 이 부분은 아직 확인하지 못했습니다. 기가비트가 필요하다면 8가닥을 모두 다시 결선해 확인해 볼 계획입니다.

---

## 정리

| 단계 | 의심한 원인 | 실제 결과 |
|------|------------|-----------|
| 1 | 오래된 NIC 드라이버(2017년) | 최신화했지만 문제 지속 |
| 2 | Speed/Duplex 강제 설정 | 정상(Auto)이라 원인 아님 |
| 3 | Hyper-V 가상 스위치 바인딩 | 바인딩 없음, 원인 아님 |
| 4 | 공유기 포트 협상 고착 | ❌ 재부팅 후 일시적으로만 복구, **오진** |
| 5 | Hyper-V/WSL 브리지가 NIC를 멈춤 | 부분 개선뿐, 원인 아님 |
| 6 | **벽 매립 랜선 끝 RJ45 접촉 불량** | ✅ 커넥터 교체 후 끊김이 크게 줄어듦 (링크 100Mbps는 미해결) |
| 7 (부수효과) | Tailscale 서비스 크래시 | 네트워크 복구 과도기에 3연속 다운 |

**교훈**:

1. 링크 속도 저하 같은 증상은 반사적으로 "드라이버 문제겠지"로 단정하기 쉽지만, 드라이버/OS 쪽 조치를 다 해봐도 안 풀린다면 **케이블과 반대편 장비까지 의심 범위를 넓혀야** 합니다. 특히 오토 네고시에이션은 양쪽이 합의해야 하는 과정이라, 한쪽만 아무리 만져봐야 답이 안 나올 수 있습니다.
2. **"재부팅했더니 됐다"는 해결의 증거가 아닙니다.** 일시적으로 링크가 재협상된 것일 수 있어서, 같은 조건에서 며칠 지켜보고 나서 결론을 내려야 합니다.
3. 물리 접촉 불량은 **커넥터를 흔들면서 연속 핑**을 보내 보면 바로 드러납니다. 가장 싸고 확실한 확인법입니다.
4. 5초짜리 끊김은 5분 간격 모니터로는 잡히지 않습니다. 1초 간격 핑처럼 **증상 길이보다 짧은 간격**으로 측정해야 합니다.
