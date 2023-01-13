import Foundation
import UIKit

final class CustomTextField: UITextField {
    private let changeText: () -> Void
    var passwordText: String = ""
    
    init(changeText: @escaping() -> Void){
        self.changeText = changeText
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(inputText), for: .editingChanged)
        self.toAutoLayout()
        self.backgroundColor = .white
        self.placeholder = NSLocalizedString("password.enter", comment: "")
        self.text = ""
    }
    
    @objc private func inputText() {
        self.changeText()
        FeedModel.shared.getPassword = self.text ?? ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
