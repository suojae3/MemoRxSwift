# RxSwift 썻을 때와 쓰지 않았을 때 비교해보기


1. 기존에 테이블뷰를 만들었을 때 작성하는 코드
```Swift
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let textField = UITextField()
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup textField and label (add to view, set constraints, etc.)

        textField.delegate = self
    }

    // MARK: - UITextFieldDelegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        label.text = newText
        return true
    }
}
```

2. RxSwift를 적용했을 때 코드
```Swift
import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let textField = UITextField()
    let label = UILabel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup textField and label (add to view, set constraints, etc.)

        // Bind the textField's text to the label using RxSwift
        textField.rx.text
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}
```
