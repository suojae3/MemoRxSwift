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

#

### 후기
- 관련된 유튜브 영상 및 블로그 자료를 찾아보고 토이프로젝트를 더 해봐야지 알 것 같다.
