import UIKit

class FeedViewController: UIViewController {
    
    var passwordText: String = ""
    
    lazy private var firstButton: CustomButton = {
        var firstButton = CustomButton(title: NSLocalizedString("first.button", comment: ""), titleColor: Palette.blackAndWhite) {
            let postVC = PostViewController()
            self.navigationController?.pushViewController(postVC, animated: true)
            postVC.postTitle = NSLocalizedString("first.button", comment: "")
        }
        
        return firstButton
    }()
    
    lazy private var secondButton: CustomButton = {
        var secondButton = CustomButton(title: NSLocalizedString("second.button", comment: ""), titleColor:  Palette.blackAndWhite) {
            let postVC = PostViewController()
            self.navigationController?.pushViewController(postVC, animated: true)
            postVC.postTitle = NSLocalizedString("second.button", comment: "")
        }
        
        return secondButton
    }()
    
    lazy private var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    var feedTextfield: CustomTextField = {
        let customTextfield = CustomTextField {}
        
        return customTextfield
    }()
    
    lazy private var checkGuessButton: CustomButtonTF = {
        var passwordCheckButton = CustomButtonTF {}
        
        return passwordCheckButton
    }()
    
    lazy var statusLabel: UILabel = {
        let stateLabel = UILabel()
        stateLabel.isHidden = true
        
        return stateLabel
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("feed.title", comment: "")
        self.view.addSubview(stackView)
        stackView.addArrangedSubviews(firstButton, secondButton, feedTextfield, checkGuessButton, statusLabel)
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.backgroundColor = Palette.feedBackground
        setupConstraints()
        
        let notify = NotificationCenter.default
        notify.addObserver(self, selector: #selector(passwordCorrect), name: Notification.Name("Correct"), object: nil)
        notify.addObserver(self, selector: #selector(passwordWrong), name: Notification.Name("Wrong"), object: nil)
    }
    
    //MARK: - passwordCheck
    @objc func passwordCorrect() {
        statusLabel.text = NSLocalizedString("password.correct", comment: "")
        statusLabel.textColor = .systemGreen
        statusLabel.isHidden = false
    }
    
    @objc func passwordWrong() {
        statusLabel.text = NSLocalizedString("password.wrong", comment: "")
        statusLabel.textColor = .systemRed
        statusLabel.isHidden = false
    }
    
    
    //MARK: - setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: self.view.bounds.width/2),
            stackView.heightAnchor.constraint(equalToConstant: self.view.bounds.height/4),
        ])
    }
    
    //MARK: - button tapped
    @objc private func buttonTapped() {
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: true)
    }
}
