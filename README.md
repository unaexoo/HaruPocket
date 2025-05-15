# HaruPocket

<div align="center">

  

<img src="https://github.com/user-attachments/assets/fde04fdc-74f0-453d-be49-8e0ca65ec1f5" width="200"/>


<h1>HaruPocket</h1>

  

<h3>단순한 지출이 아닌, 하루를 되짚는 기록</h3>

  

<p>

누적된 금액보다 중요한 건, 그날의 내가 왜 소비했는지를 돌아보는 것.<br/>

HaruPocket은 소비를 통해 나를 이해하고 삶의 흐름을 기록할 수 있도록 도와주는,<br/>

회고 중심 소비 기록 앱입니다.

</p>

  

</div>

  

---

  

## 🧭 Introduction

  

대부분의 가계부 앱은 숫자 중심의 소비 기록과 합계, 통계 제공에 초점을 맞춥니다.

하지만 우리는 생각했습니다.

  

> *"단순히 얼마를 썼는지가 아니라,

> 왜 그 소비를 했는지를 돌아볼 수 있다면 어떨까?"*

  

HaruPocket은 그런 질문에서 출발했습니다.

소비의 맥락, 감정, 목적을 기록하고 되짚으며,

**‘기억할 수 있는 소비’**로 남기는 것이 이 앱의 핵심입니다.

  

---

  

## 🎯 이 앱이 필요한 사람

  

- 오늘의 소비를 **의미 있는 기억**으로 남기고 싶은 사람

- 소비를 단순한 감시가 아닌 **성찰과 회고**의 도구로 쓰고 싶은 사람

- 통장만 들여다보는 것이 아니라 **내 삶을 돌아보고 싶은 사람**

- 숫자 위주의 가계부 앱에 **스트레스나 피로감을 느낀 적이 있는 사람**

  

---

  

## ✨ 주요 기능 소개

  

### 📝 1. 소비 회고 메모

- 소비 이유와 감정을 메모로 남겨 스스로 소비를 되짚을 수 있도록 합니다.

- 작성된 회고는 언제든지 열람, 수정, 삭제할 수 있습니다.

  

### 🗂️ 2. 카테고리별 분류 및 관리

- 카테고리를 직접 만들고 색상·이모지를 지정해 시각적으로 분류할 수 있습니다.

- 삭제된 카테고리는 자동으로 ‘카테고리 없음’으로 이동합니다.

  

### 📆 3. 달력형 일간 소비 뷰

- 소비 내역이 달력에 표시되어, 날짜별 소비 흐름을 직관적으로 파악할 수 있습니다.

- 리스트 및 상세 회고 확인도 함께 가능합니다.

  

### 📊 4. 월별 소비 통계 시각화

- **가장 많이 쓴 항목**: 총 지출 금액 기준 도넛 차트로 시각화

- **가장 자주 쓴 항목**: 소비 횟수 기준으로 반복 소비 습관을 확인 가능

  

---



## 🚀 실행 방법

### 1. 프로젝트 클론

```bash
git clone https://github.com/jihyeonjjang/HaruPocket.git
cd HaruPocket
```

### 2. Xcode에서 열기

* `HaruPocket.xcodeproj` 또는 `HaruPocket.xcworkspace`를 **Xcode 15 이상**에서 엽니다.

### 3. 패키지 설치 확인

* 프로젝트를 열면 자동으로 **EmojiPicker 2.1.1**이 설치됩니다.
* 설치 오류가 발생할 경우 `File > Packages > Resolve Package Versions`를 선택하세요.

### 4. 실행

* 시뮬레이터 또는 실제 디바이스를 선택 후 ▶️ 버튼으로 실행합니다.

### 5. 미리보기 사용 (옵션)

* `#Preview` 구조와 `inMemory` 컨테이너를 이용해 SwiftUI 뷰 미리보기가 가능합니다.

---
## 📦 의존 라이브러리

| 라이브러리 이름 | 버전 | 설명 |
|----------------|------|------|
| [EmojiPicker](https://github.com/hsousa/EmojiPicker) | 2.1.1 | SwiftUI 기반의 이모지 선택 컴포넌트로, HaruPocket의 카테고리 생성 시 이모지 선택 UI에 사용됩니다. |

- Swift Package Manager(SPM)를 통해 자동으로 설치됩니다.
- 프로젝트 실행 시 필요한 경우 다음 메뉴에서 수동 갱신할 수 있습니다:
---

## 📁 프로젝트 구조

```
HaruPocket
├── Font                        # 앱에 사용되는 폰트 리소스
│   ├── Jua-Regular             # 주 폰트 파일
│   └── OFL                    # 폰트 라이선스 파일
│
├── SampleImage                # 샘플 소비 항목 이미지
│   ├── bbq
│   ├── book
│   ├── brunch
│   ├── exhibition
│   ├── flower
│   ├── friedChicken
│   ├── gift
│   ├── gym
│   ├── musical
│   └── shopping
│
├── HaruPocket
│   ├── Model                  # 데이터 및 뷰모델 정의
│   │   ├── BasicEntry.swift
│   │   ├── BasicEntry+SampleData.swift
│   │   ├── CalendarViewModel.swift
│   │   ├── Category.swift
│   │   ├── Category+SampleData.swift
│   │   ├── ColorHex.swift
│   │   └── SpendingViewModel.swift
│   │
│   ├── Assets                 # 주요 화면 및 UI 컴포넌트
│   │   ├── CategoryComposeView.swift
│   │   ├── CategoryListComposeView.swift
│   │   ├── CategoryListView.swift
│   │   ├── CategoryView.swift
│   │   ├── Color+Predefined.swift
│   │   ├── ComposeView.swift
│   │   ├── CustomCalendarView.swift
│   │   ├── DetailView.swift
│   │   ├── HaruPocketApp.swift
│   │   ├── Info.plist
│   │   ├── PhotoView.swift
│   │   ├── SelectCategoryView.swift
│   │   ├── StaticsViewModel.swift
│   │   └── StatisticsView.swift
│
└── Package Dependencies       # 외부 라이브러리
    └── EmojiPicker 2.1.1      # 이모지 선택 라이브러리
```

## 🖼️ 앱 주요 화면

  

| 홈 화면 (달력 + 리스트)      | 회고 메모 작성          | 월별 통계 화면 | 카테고리 분류 화면 |

|----------------------------|---------------------------|----------------------------|----------------------------|

| <img src="https://github.com/user-attachments/assets/5201b697-6663-4da7-897c-d5768a5b8624" width="190"/> | <img src="https://github.com/user-attachments/assets/a67a2154-f90a-4980-9484-d1b92063910a" width="190"/> | <img src="https://github.com/user-attachments/assets/f7cfac11-c081-4002-b4ed-869c08d7687d" width="190"/> | <img src="https://github.com/user-attachments/assets/e5c33f7d-3a42-496a-b2db-897ce5073db7" width="190"/>

  

---

  

## 🧪 사용 방법

  

1. 홈 탭에서 `+` 버튼으로 소비 항목을 추가하고, 회고 메모를 작성하세요.

2. 리스트에서 소비 내역을 열람, 수정, 삭제할 수 있습니다.

3. 카테고리 탭에서 소비 항목을 시각적으로 분류할 수 있습니다.

4. 통계 탭에서 월별 소비 패턴과 반복 소비 항목을 분석하세요.

  

---

  

## ⚙️ 기술 스택

  

| 항목 | 내용 |

|------|------|

| 언어 | Swift 5.9 |

| UI 프레임워크 | SwiftUI |

| 데이터 관리 | SwiftData (로컬 기반 ORM) |

| IDE | Xcode 15 이상 |

| 미리보기 구성 | `#Preview` + `.modelContainer(inMemory: true)` |

  

---

  

## 🤝 협업 문화

  

HaruPocket은 작은 규모의 프로젝트였지만,

**지속적이고 유기적인 협업 루틴**을 통해 높은 완성도를 유지했습니다.

  

### 🗓️ 매일 1회 회의 및 회의록 기록

- 매일 짧은 회의를 통해 진행 상황을 점검하고, 결정 사항을 Notion에 기록했습니다.

- 회의록을 통해 히스토리를 관리하고, 피드백을 빠르게 반영했습니다.

  

### 🧩 매일 이슈 확인 및 작업 공유

- GitHub Issues 또는 개인 작업 보드를 통해 개발 중인 기능과 상태를 실시간으로 공유했습니다.

- 기능 단위의 작은 작업도 기록하고, 완료 시점과 우선순위를 명확히 설정했습니다.

  

> 이러한 루틴 덕분에 변화에 민첩하게 대응하고,

> 개발 중간중간에도 팀원 간의 업무 흐름을 명확히 이해할 수 있었습니다.

  

---

  

## 👤 개발자

| 이름  | 역할                    | GitHub                                             |
| --- | --------------------- | -------------------------------------------------- |
| 장지현 | iOS 개발 / 기획 / 디자인     | [@jihyeonjjang](https://github.com/jihyeonjjang)   |
| 고재현 | iOS 개발 / 디자인 / PPT 제작 | [@gojaeheon](https://github.com/JaeHyun9802)         |
| 윤혜주 | iOS 개발 / 데이터 모델링 / 발표 | [@unaexoo](https://github.com/unaexoo)         |
| 전윤철 | iOS 개발 / 문서 작성        | [@yooncheoljeon](https://github.com/JYC0609) |

  

## 🪪 라이선스

  

이 프로젝트는 MIT 라이선스를 따릅니다.

자유롭게 사용, 수정, 배포할 수 있으며 반드시 라이선스 문구를 포함해주세요.
