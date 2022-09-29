import Foundation
import UIKit

final class CustomButton: UIButton {
    
    private var buttonAction: () -> Void
    
    init(title: String, titleColor: UIColor, buttonAction: @escaping() -> Void){
        self.buttonAction = buttonAction
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        self.toAutoLayout()
        self.backgroundColor = UIColor.blue
    }
    
    @objc func buttonTapped(){
        self.buttonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
