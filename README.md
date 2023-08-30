## RxSwift 사용할 때와 사용하지 않았을 때 비교해보기

#

### 비교1: 데이터 관리
```swift
//RxSwift
private var memos: BehaviorRelay<[Memo]> = BehaviorRelay(value: [])
```
```swift
//Traditional
private var memos: [Memo] = [] 
```
- `BehaviorRelay` 라는 관찰되는(observable) 배열을 통해 변경사항을 자동적으로 반영한다
- 기존의 배열같은 경우 변경사항을 반영하려면 `tableView.reloadData()`을 매번 써줘야했음

#

### 비교2: 테이블뷰 셋팅
```swift
//RxSwift
memos.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, memo, cell) in
    cell.textLabel?.text = memo.content
}
.disposed(by: disposeBag)
```
```swift
//Traditional
tableView.delegate = self
tableView.dataSource = self
```
- 바인딩된 `memos` 데이터를 즉각적으로 테이블뷰에 반영한다. 이렇게 함으로서 델리게이트와 소스를 없애줄 수 있다.
- 기존에는 `viewDidLoad()`에 delegate와 source를 넣는 델리게이트 패턴을 구현해야했음(테이블뷰), 아래에 필수구현 메서드까지 적는건 덤


#

 ### 비교3: 메모 추가 후 UI업데이트 
```swift
//RxSwift
if let content = alertController.textFields?.first?.text, !content.isEmpty {
    let newMemo = Memo(content: content)
    var currentMemos = memos.value
    currentMemos.append(newMemo)
    memos.accept(currentMemos)
}
```
```swift
//Traditional
if let content = alertController.textFields?.first?.text, !content.isEmpty {
    let newMemo = Memo(content: content)
    memos.append(newMemo)
    tableView.reloadData()
}
```
- `memos` 데이터는 관찰되고 있기 때문에 따로 `reloadData()`를 해줄 필요가 없음

#

### 후기
- 관련된 유튜브 영상 및 블로그 자료를 찾아보고 토이프로젝트를 더 해봐야지 알 것 같다.
