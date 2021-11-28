# 숙소 예약 서비스 앱 

### 요구사항
아이폰 계열 모든 화면 크기에서 동일하게 보이도록 오토레이아웃으로 작업<br>
TableView 보다 CollectionView를 사용<br>
가격 범위 그래프는 Core Graphics 수준에서 구현하는 것을 권장<br>
적절한 화면 요소를 표시하기 위한 스스로 기준으로 결정<br>
고려할 사항: 재사용성, 레이아웃, 반응성, 효율성<br>
Custom 달력 컨트롤러 구현 <br>

### 앱 주요 기능 

```
- 숙소 지역 검색
- 예약 기간 설정
- 가격 범위 설정
- 인원 설정
- 맞춤 숙소 검색 결과 및 지도 위치 화면
- 숙소 상세 보기 및 총 가격 화면
- 커스텀 UI(기간 선택, 가격 설정) 구현
```





### 개발 기간

2021.05.17 - 2021.06.04

### 앱 구조 이미지
<img width="600" alt="스크린샷 2021-05-30 오후 2 25 01" src="https://user-images.githubusercontent.com/33626693/120970482-74064a80-c7a6-11eb-817a-38d8f719c25c.png">



### 앱 시연 화면

| <img width="264" alt="스크린샷 2021-11-24 오후 11 00 07" src="https://user-images.githubusercontent.com/33626693/143252384-3338c187-5382-4391-ab66-da9f884f933c.png"> | <img width="268" alt="스크린샷 2021-11-24 오후 11 00 50" src="https://user-images.githubusercontent.com/33626693/143252356-a73391e8-a126-4bea-845e-8879731333a3.png"> | <img width="270" alt="스크린샷 2021-11-24 오후 11 01 17" src="https://user-images.githubusercontent.com/33626693/143252967-4999f401-4812-4961-bb48-6fc50ab493c5.png"> | <img width="273" alt="스크린샷 2021-11-24 오후 11 01 27" src="https://user-images.githubusercontent.com/33626693/143252964-6e081ac4-3a44-4803-bb37-25b546a9a844.png"> |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| <img width="269" alt="스크린샷 2021-11-24 오후 11 01 46" src="https://user-images.githubusercontent.com/33626693/143252951-46c2a075-ef57-4b62-8dcb-d922a9a643f2.png"> | <img width="277" alt="스크린샷 2021-11-24 오후 11 01 58" src="https://user-images.githubusercontent.com/33626693/143252936-02508ddf-c767-4e1a-bf64-95942771fcfe.png"> | <img width="267" alt="스크린샷 2021-11-24 오후 11 02 09" src="https://user-images.githubusercontent.com/33626693/143252932-cd373bd8-2437-4b98-866f-c4a81009d900.png"> | <img width="270" alt="스크린샷 2021-11-24 오후 11 02 14" src="https://user-images.githubusercontent.com/33626693/143252916-4bc66fee-ca88-4b7e-9aa6-c7fca5277af6.png"> |
--- 

| ![ezgif com-video-to-gif-17](https://user-images.githubusercontent.com/33626693/120970317-3d303480-c7a6-11eb-90b6-29c065c919c5.gif) | ![ezgif com-video-to-gif-18](https://user-images.githubusercontent.com/33626693/120970677-b16ad800-c7a6-11eb-8e1a-071ba4ead020.gif) | ![ezgif com-video-to-gif-19](https://user-images.githubusercontent.com/33626693/120970764-d0696a00-c7a6-11eb-84ed-a4f711cd9c48.gif) | ![ezgif com-video-to-gif-20](https://user-images.githubusercontent.com/33626693/120970796-da8b6880-c7a6-11eb-8890-e3d50030a21e.gif) |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 메인 화면 및 지역검색                                        | 날짜 선택화면(Custom UI)                                     | 가격 선택화면(Custom UI)                                     | 인원 선택화면                                                |

| ![ezgif com-video-to-gif-21](https://user-images.githubusercontent.com/33626693/120970832-e840ee00-c7a6-11eb-8b80-65926801e5a6.gif) | ![ezgif com-video-to-gif-22](https://user-images.githubusercontent.com/33626693/120970924-03abf900-c7a7-11eb-898f-244471f00a23.gif) | ![ezgif com-video-to-gif-23](https://user-images.githubusercontent.com/33626693/120970999-1e7e6d80-c7a7-11eb-9082-9347c8c2636a.gif) |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 숙소 검색결과 화면                                           | 숙소 검색결과(지도)                                          | 숙소 상세화면 및 숙소 견적                                   |

---

### 진행 과정 중 문제점 및 해결 방안

- 라이브러리를 사용하지 않고 컬렉션뷰를 이용한 커스텀 달력 구현
- 커스텀 슬라이더 구현


<details>
    <summary>커스텀 달력</summary>
    <div markdown="1">
    #### 커스텀 달력 레이아웃 구성

<img width="862" alt="스크린샷 2021-11-24 오후 11 37 51" src="https://user-images.githubusercontent.com/33626693/143258407-2dcff6cb-9b7b-43b4-984e-6a971d3c1c5b.png">

- 요일의 화면은 바뀌지 않아 정적으로 만들어 구현하였습니다
- 년 월 표시는 달마다 한번씩 이므로 Header에 표시하며 일 표시는 Cell 담당하도록 구현 했습니다



#### 달력 계산 하기

#### <img width="244" alt="스크린샷 2021-11-26 오후 10 15 30" src="https://user-images.githubusercontent.com/33626693/143586803-63f0b717-85e4-461e-8dc7-330a08842178.png">

1. 현재 Date 값을 통해 해당 달의 일 수를 구합니다

2. 현재 Date 값의 첫째 날의 Date 가져옵니다

3. 현재 달의 첫째날을 몇요일인지 Int 값으로 받습니다.  요일 값에서 -1 을 해주는 이유는 요일의 범위는 1-7 이지만 UI 시작은 0부터 이므로 0-6이 되도록  맞추기위해 -1을 해줍니다. 

   요일 값을 구하는 이유는 첫 주의 시작날을 기준으로 Day 계산하기 위함 입니다.

4. 0 부터 달의 일 수 + 요일 값까지 범위를 지정 후  반복을 해줍니다.  

5. 루프는 돌면서 루프 카운터가 요일(Int) 값 보다 작다면 nil

   작지 않거나 크다면 루프 카운터 - 요일값의 변수로 첫날을 기준으로 날을 증가 합니다.

```swift
private  func makeDays(date: Date) -> [Date?] {
    var days: [Date?] = []
    let dayCount = daysInMonth(date: date)
    let firstDay = firstDayOfMonth(date: date)
    let startingSpaces = weekDayCount(date: firstDay)
    (0..<dayCount + startingSpaces).forEach { (count) in
        checkFirstDayRange(day: count, spaceInt: startingSpaces) ?
            days.append(nil) :
            days.append(createDay(with: count - startingSpaces, firstDay: firstDay))
    }
    return days
}

private func createDay(with count: Int, firstDay: Date) -> Date {
    return calendar.date(byAdding: .day, value: count, to: firstDay) ?? Date()
}

private func checkFirstDayRange(day: Int, spaceInt: Int) -> Bool {
    return day < spaceInt
}

private func daysInMonth(date: Date) -> Int {
    let range = calendar.range(of: .day, in: .month, for: date)!
    return range.count
}

private func firstDayOfMonth(date: Date) -> Date {
    let components = calendar.dateComponents([.year, .month], from: date)
    return calendar.date(from: components) ?? Date()
}

private func weekDayCount(date: Date) -> Int {
    let components = calendar.dateComponents([.weekday], from: date)
    return (components.weekday ?? 1) - 1
}
```

달의 일(day) 계산 하는 로직 코드는 위와 같습니다.



### Collection Header에 들어가  년 월 구하기

<img width="131" alt="스크린샷 2021-11-26 오후 10 15 55" src="https://user-images.githubusercontent.com/33626693/143586801-de03f236-fd99-4aab-a701-e694d6aebdda.png">

현재 Date 값을 DateFormatter를 활용해 "yyyy년 M월" 형식으로 반환 되도록 구현하였습니다.

```swift
let months = dateFormatter.convertCalenderHeaderString(date: month)
```



### CollecitonViewDataSource 전달

```swift
// DataSource
private let months: [String]
private let days: [[Date?]]

func numberOfSections(in collectionView: UICollectionView) -> Int {
    return months.count
}

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return days[section].count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDayCell.identifier, for: indexPath) as? CalendarDayCell else {
            return .init()
        }
     let day = days[indexPath.section][indexPath.row] ?? .init()
     cell.configure(day: day)
}
```

년 월 과 일은 배열로 가지고 CollectionView DataSoure에 전달하여 UI를 그리도록 하였습니다.

</details>

<details>
    <summary>커스텀 슬라이더</summary>
    <div markdown="1">


### 커스텀 슬라이드 레이아웃 구성

<img width="682" alt="스크린샷 2021-11-26 오후 10 17 07" src="https://user-images.githubusercontent.com/33626693/143586927-4e12e280-d71e-4b29-aaa8-3019d9add957.png">

- 기본적으로 UISlider는 하나의 액션 핸들러만 존재하여 직접 양방향 Slider를 만들게 되었습니다.

- 커스텀 Slider는 UISlider의 상위 클래스인 UIControl로 구현하였습니다.



#### 동작 속성 구성

```swift
var minimumValue: CGFloat = 0 // Slider 최소범위
var maximumValue: CGFloat = 1 // Slider 최대범위
var lowerValue: CGFloat = 0.0 // thumb Image 위치 
var upperValue: CGFloat = 1.0 // thumb Image 위치

private let trackLayer = CALayer()
private let lowerThumbImageView = UIImageView()
private let upperThumbImageView = UIImageView()
```

- 슬라이더의 최소 최대 범위와 thumb 이미지의 위치 값 초기화 합니다.
- 슬라이더 배경 layer 및 동작 할 Thumb 이미지 두개를 초기화 합니다.

#### 슬라이더 UI 위치 지정

#### <img width="651" alt="스크린샷 2021-11-26 오후 10 17 17" src="https://user-images.githubusercontent.com/33626693/143586922-241a2393-e077-4d73-8f15-7a698740d6e9.png">

```swift
func updateLayerFrames() {
    trackLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    trackLayer.setNeedsDisplay()
    
    lowerThumbImageView.frame = CGRect(origin: thumbOriginForValue(lowerValue),
                                       size: .init(width: 30, height: 30))
    upperThumbImageView.frame = CGRect(origin: thumbOriginForValue(upperValue),
                                       size: .init(width: 30, height: 30))
}

private func positionForValue(_ value: CGFloat) -> CGFloat {
    return bounds.width * value
}

private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
    let x = positionForValue(value) - thumbImage.size.width / 2.0
		return CGPoint(x: x, y: bounds.height*0.95)
}
```

- updateLayerFrames 메서드를 통해서  배경 레이어 및 Thumb 이미지 위치를 업데이트 합니다.
- 각 thumb image 위치의 경우 
  x 위치의 경우  UIControl bounds 넓이 * thumb (lower or upper) Value  반환 값과 이미지 크기 반절을 뺸 값을 지정하고
  y 위치 경우  UIControl bounds 높의 * 0.95 비율로 값으로 그래프 바닥에 위치하도록 구현하였습니다.

#### 터치 핸들러 추가

```swift
private var previousLocation = CGPoint()

override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {}
override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {}
override func endTracking(_ touch: UITouch?, with event: UIEvent?) {}
```

- CGPoint 객체를 활용하여 터치 위치를 추적하도록 하였습니다.
- 사용자 지정 터치 컨트롤로 `beginTracking` , `continueTracking`, `endTracking`   터치 움직임을 감지하는 메서드 활용해 구현하였습니다.

```swift
override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    
    previousLocation = touch.location(in: self)
    
    if lowerThumbImageView.frame.contains(previousLocation) {
        lowerThumbImageView.isHighlighted = true
    } else if upperThumbImageView.frame.contains(previousLocation) {
        upperThumbImageView.isHighlighted = true
    }
    
    return lowerThumbImageView.isHighlighted || upperThumbImageView.isHighlighted
}
```

- 터치 추적 시작을 알리는 콜백입니다,  
- touch.location(in: self) UIControl을 터치시 해당 x,y 좌표 값을 알 수 있습니다. 
  해당 좌표값이 lowerImage 또는 upperImage frame에 포함되어있다면 highted를 true 변경하도록 하였습니다.

```swift
override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    let location = touch.location(in: self)
    
    let deltaLocation = location.x - previousLocation.x
    let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width
    
    previousLocation = location
    
    if lowerThumbImageView.isHighlighted {
        lowerValue += deltaValue
        lowerValue = boundValue(lowerValue, toLowerValue: minimumValue,
                                upperValue: upperValue)
    } else if upperThumbImageView.isHighlighted {
        upperValue += deltaValue
        upperValue = boundValue(upperValue, toLowerValue: lowerValue,
                                upperValue: maximumValue)
    }
    
    sendActions(for: .valueChanged)
    return true
}

private func boundValue(_ value: CGFloat, toLowerValue lowerValue: CGFloat,
                        upperValue: CGFloat) -> CGFloat {
    return min(max(value, lowerValue), upperValue)
}
```

- 터치 추적 중 실행되는 콜백 입니다
- 먼저 사용자의 손가락이 이동한 델타 위치를 계산합니다. 그런 다음 컨트롤의 최소값과 최대값을 기반으로 조정된 델타 값으로 변환합니다.
  사용자가 슬라이더를 드래그하는 위치에 따라 상한 또는 하한 값을 조정합니다.
- Lower 값 또는 Upper 값이 각각 범위를 벗이나지 않도록 boundValue 메서드를 통해 조정합니다.

```swift
override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    lowerThumbImageView.isHighlighted = false
    upperThumbImageView.isHighlighted = false
}
```

- 터치 추적이 종료시 실행되는 콜백입니다.
- 터치 추적이 끝나면 이미지 강조 표시되지 않은 상태로 재설정합니다. 
</details>
  
---


#### 간단한 회고
  중간 회고
  - 잘한점
      - 새로운 협업도구로 지라를 활용하면서 각자 이슈를 확인하고 서로 진행사항을 한눈에 볼 수 있어 협업에서 사용하는 업무적인 툴을 경험해봤다!
      - 기존에 없던 UI를 직접 커스텀 제작했다.
      - 팀워크를 다지기 위해 노력함 다들 잘 따라와줘서 고맙다
   - 아쉬운점
       - 커스텀 UI(캘린더,그래프) 제작에 시간을 많이 소모한점..그래서 개발속도가 늦어진 감이 없지 않다
       - 시간을 투자한 만큼 효율이 좋지 않았다.ㅠㅠ 
       - 난 왜 개발을 못하는가....
       - 다형성을 넣어주지못했다😭
 - 다음주 목표
     - 미션 완료🔥

프로젝트 종료 후
 -  좋았던 점
    - soild 원칙을 지키며 만들려고 노력했었는데 
    - 이번 프로젝트 구조를 만들면서 OCP에 대해서 변화에 자주 생기는 곳에서 유연하게 개선해야한다는것을 느꼈습니다

 - 아쉬운 점 
    - 이번 미션에서는 생활패턴을 망치면서 3주동안프로젝트 작업을 했었는데 
    - 몸이 많이 상하는것을 느껴서 다음 프로젝트에는 건강한 생활패턴을 찾아서 건강을 챙기도록 노력하려고합니다



