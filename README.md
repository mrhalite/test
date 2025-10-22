# iOS 달력 앱

SwiftUI와 WidgetKit을 사용한 iOS 달력 애플리케이션입니다.

## 기능

### 메인 앱
- 📅 월간 달력 뷰
- 📍 날짜 선택 기능
- 🎨 한국어 로케일 지원
- 🔵 오늘 날짜 강조 표시
- 🔴 일요일 빨간색, 토요일 파란색 표시
- ⬅️ ➡️ 월 간 이동 기능

### 홈 화면 위젯
- **작은 위젯**: 오늘 날짜 표시
- **중간 위젯**: 이번 주 날짜 표시
- **큰 위젯**: 전체 월 달력 표시

## 프로젝트 구조

```
CalendarApp/
├── CalendarApp.swift          # 앱 진입점
├── ContentView.swift           # 메인 화면
├── CalendarView.swift          # 달력 컴포넌트
└── Models/
    └── CalendarModel.swift     # 달력 데이터 모델

CalendarWidget/
└── CalendarWidget.swift        # 홈 화면 위젯
```

## 사용 기술

- **SwiftUI**: 선언적 UI 프레임워크
- **WidgetKit**: 홈 화면 위젯
- **Calendar API**: 날짜 계산 및 조작

## 설치 및 실행

### 요구사항
- Xcode 14.0 이상
- iOS 16.0 이상
- macOS Ventura 이상 (개발용)

### 실행 방법

1. Xcode에서 새 프로젝트 생성:
   - iOS App 템플릿 선택
   - Product Name: "CalendarApp"
   - Interface: SwiftUI
   - Language: Swift

2. 프로젝트에 파일 추가:
   ```
   CalendarApp/
   ├── CalendarApp.swift
   ├── ContentView.swift
   ├── CalendarView.swift
   └── Models/
       └── CalendarModel.swift
   ```

3. Widget Extension 추가:
   - File > New > Target > Widget Extension
   - Product Name: "CalendarWidget"
   - "Include Configuration Intent" 체크 해제
   - `CalendarWidget/CalendarWidget.swift` 파일의 내용을 대체

4. Info.plist 설정:
   - 메인 앱과 위젯에 적절한 권한 추가
   - App Groups 설정 (데이터 공유가 필요한 경우)

5. 시뮬레이터 또는 실제 기기에서 실행

## 위젯 사용법

1. 앱을 실행하여 설치
2. 홈 화면에서 길게 누르기
3. 오른쪽 상단 "+" 버튼 클릭
4. "CalendarWidget" 검색
5. 원하는 크기 선택 (작게/중간/크게)
6. "위젯 추가" 탭

## 주요 컴포넌트

### CalendarView
달력 그리드를 표시하는 재사용 가능한 SwiftUI 뷰입니다.

```swift
CalendarView(selectedDate: $selectedDate)
```

### CalendarWidget
세 가지 크기의 홈 화면 위젯을 제공합니다:
- `SmallCalendarWidget`: 오늘 날짜
- `MediumCalendarWidget`: 이번 주
- `LargeCalendarWidget`: 전체 월

## 커스터마이징

### 색상 변경
`CalendarView.swift`와 `CalendarWidget.swift`에서 색상을 변경할 수 있습니다:

```swift
.foregroundColor(.blue) // 원하는 색상으로 변경
```

### 로케일 변경
현재 한국어로 설정되어 있습니다. 다른 언어로 변경하려면:

```swift
formatter.locale = Locale(identifier: "en_US") // 영어
formatter.locale = Locale(identifier: "ja_JP") // 일본어
```

## 향후 개선 사항

- [ ] 이벤트 추가/삭제 기능
- [ ] 이벤트 알림 기능
- [ ] 다크 모드 최적화
- [ ] 위젯에서 앱으로 딥 링크
- [ ] iCloud 동기화
- [ ] Apple Calendar 통합
- [ ] 다양한 캘린더 테마

## 라이센스

MIT License

## 기여

이슈와 풀 리퀘스트는 언제나 환영합니다!

## 작성자

Claude - AI Assistant
