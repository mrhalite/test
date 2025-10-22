# iOS 달력 앱 설정 가이드

이 문서는 Xcode에서 프로젝트를 설정하는 방법을 단계별로 설명합니다.

## 1. 새 Xcode 프로젝트 생성

1. Xcode를 열고 "Create a new Xcode project" 선택
2. iOS 탭에서 "App" 선택
3. 다음 설정 입력:
   - **Product Name**: `CalendarApp`
   - **Team**: 본인의 개발 팀 선택
   - **Organization Identifier**: `com.yourname` (예: com.john)
   - **Bundle Identifier**: 자동 생성됨 (예: com.john.CalendarApp)
   - **Interface**: `SwiftUI`
   - **Language**: `Swift`
   - **Storage**: `None`
   - **Include Tests**: 체크 해제 가능
4. 프로젝트 저장 위치 선택

## 2. 메인 앱 파일 추가

### 2.1. 기존 파일 대체

1. `CalendarApp.swift` 파일을 이 리포지토리의 내용으로 대체
2. `ContentView.swift` 파일을 이 리포지토리의 내용으로 대체

### 2.2. 새 파일 추가

1. **CalendarView.swift 추가**:
   - File > New > File... (⌘N)
   - Swift File 선택
   - 이름: `CalendarView`
   - 이 리포지토리의 `CalendarApp/CalendarView.swift` 내용 복사

2. **Models 폴더 생성**:
   - CalendarApp 그룹에서 우클릭 > New Group
   - 이름: `Models`

3. **CalendarModel.swift 추가**:
   - Models 폴더에서 File > New > File...
   - Swift File 선택
   - 이름: `CalendarModel`
   - 이 리포지토리의 `CalendarApp/Models/CalendarModel.swift` 내용 복사

## 3. Widget Extension 추가

### 3.1. 새 Target 생성

1. File > New > Target... (또는 프로젝트 네비게이터에서 프로젝트 선택)
2. iOS 탭에서 "Widget Extension" 선택
3. 다음 설정 입력:
   - **Product Name**: `CalendarWidget`
   - **Include Configuration Intent**: 체크 해제
4. "Finish" 클릭
5. "Activate" 대화상자에서 "Activate" 선택

### 3.2. Widget 파일 수정

1. `CalendarWidget/CalendarWidget.swift` 파일 열기
2. 전체 내용을 이 리포지토리의 `CalendarWidget/CalendarWidget.swift` 내용으로 대체

## 4. 프로젝트 설정

### 4.1. 메인 앱 설정

1. 프로젝트 네비게이터에서 프로젝트 선택
2. TARGETS에서 "CalendarApp" 선택
3. **General** 탭:
   - **Minimum Deployments**: iOS 16.0 이상 설정
   - **Display Name**: "달력"
4. **Info** 탭:
   - Localization > Development Language: Korean 추가

### 4.2. Widget Extension 설정

1. TARGETS에서 "CalendarWidget" 선택
2. **General** 탭:
   - **Minimum Deployments**: iOS 16.0 이상 설정 (메인 앱과 동일)
3. **Signing & Capabilities**:
   - 메인 앱과 동일한 Team 선택
   - Bundle Identifier가 자동으로 설정됨 (예: com.john.CalendarApp.CalendarWidget)

## 5. 빌드 및 실행

### 5.1. 시뮬레이터에서 실행

1. 상단 툴바에서 시뮬레이터 선택 (예: iPhone 15 Pro)
2. ⌘R 키를 눌러 빌드 및 실행
3. 앱이 시뮬레이터에서 실행됨

### 5.2. 위젯 테스트

1. 시뮬레이터 홈 화면으로 이동 (⇧⌘H)
2. 빈 공간을 길게 누르기 (또는 우클릭)
3. 왼쪽 상단 "+" 버튼 클릭
4. "CalendarWidget" 검색
5. 세 가지 크기 중 선택:
   - **작게**: 오늘 날짜만 표시
   - **중간**: 이번 주 표시
   - **크게**: 전체 월 표시
6. "위젯 추가" 탭

### 5.3. 실제 기기에서 실행

1. Lightning/USB-C 케이블로 iPhone/iPad 연결
2. Xcode 상단 툴바에서 연결된 기기 선택
3. **Signing & Capabilities** 탭에서:
   - Team에 유료 Apple Developer 계정 선택
   - 또는 무료 개인 팀 선택 (7일 제한)
4. ⌘R 키를 눌러 빌드 및 실행
5. 기기에서 "설정 > 일반 > VPN 및 기기 관리"에서 개발자 인증서 신뢰

## 6. 문제 해결

### 빌드 오류

**에러: "No account for team"**
- 해결: Signing & Capabilities에서 Team 선택

**에러: "Command SwiftCompile failed"**
- 해결: Product > Clean Build Folder (⇧⌘K) 후 재빌드

**에러: Widget이 표시되지 않음**
- 해결:
  1. 앱을 먼저 실행하여 설치
  2. 시뮬레이터 재시작
  3. Xcode에서 Widget scheme 선택 후 실행

### 시뮬레이터 문제

**위젯이 업데이트되지 않음**
- 해결:
  1. 위젯 길게 누르기 > "위젯 편집" > 완료
  2. 또는 시뮬레이터 재시작

**날짜가 잘못 표시됨**
- 해결: 시뮬레이터의 시스템 시간 확인

## 7. 추가 커스터마이징

### 앱 아이콘 추가

1. Assets.xcassets 선택
2. AppIcon 선택
3. 필요한 크기의 아이콘 이미지 드래그 앤 드롭
   - 1024x1024 (App Store)
   - 180x180 (iPhone)
   - 등...

### 다크 모드 지원

코드는 이미 다크 모드를 지원합니다:
- `.background(Color(.systemBackground))` 사용
- 시스템 색상 자동 적용

### 로케일 변경

한국어가 아닌 다른 언어로 변경하려면:

```swift
// CalendarView.swift 및 CalendarWidget.swift에서
formatter.locale = Locale(identifier: "en_US") // 영어
formatter.locale = Locale(identifier: "ja_JP") // 일본어
formatter.locale = Locale(identifier: "zh_CN") // 중국어
```

## 8. 프로젝트 구조 확인

최종 프로젝트 구조는 다음과 같아야 합니다:

```
CalendarApp/
├── CalendarApp.swift
├── ContentView.swift
├── CalendarView.swift
├── Models/
│   └── CalendarModel.swift
├── Assets.xcassets/
│   └── AppIcon.appiconset/
└── Info.plist

CalendarWidget/
├── CalendarWidget.swift
├── Assets.xcassets/
└── Info.plist
```

## 9. 배포 준비

### TestFlight 배포

1. Apple Developer Program 가입 필요 (연간 $99)
2. Archive 생성: Product > Archive
3. Organizer에서 "Distribute App" 선택
4. App Store Connect 업로드
5. TestFlight에서 베타 테스트

### App Store 배포

1. App Store Connect에서 앱 정보 입력
2. 스크린샷 및 앱 설명 추가
3. 심사 제출
4. 승인 후 출시

## 도움이 필요하신가요?

- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [WidgetKit Documentation](https://developer.apple.com/documentation/widgetkit)

즐거운 개발 되세요! 🎉
