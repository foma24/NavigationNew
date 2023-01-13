import Foundation
import UIKit

final class CustomButtonTF: UIButton {
    var buttonTapped: () -> Void
    
    init(buttonTapped: @escaping() -> Void) {
        self.buttonTapped = buttonTapped
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(checkPass), for: .touchUpInside)
        self.toAutoLayout()
        self.backgroundColor = .orange
        self.setTitle(NSLocalizedString("password.check", comment: ""), for: .normal)
        self.setTitleColor(.white, for: .normal)
    }
    
    @objc private func checkPass() {
        self.buttonTapped()
        if FeedModel.shared.getPassword != "" {
            FeedModel.shared.check()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
