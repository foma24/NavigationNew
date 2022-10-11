import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    private let viewModel: FeedViewModel
    
    var passwordText: String = ""
    
    lazy private var firstButton: CustomButton = {
        var firstButton = CustomButton(title: "First Button", titleColor: .white) {
//            let postVC = PostViewController()
//            self.navigationController?.pushViewController(postVC, animated: true)
//            postVC.postTitle = "First Button"
            
            self.viewModel.post1DidTap()
        }
        
        return firstButton
    }()
    
    lazy private var secondButton: CustomButton = {
        var secondButton = CustomButton(title: "Second Button", titleColor: .white) {
//            let postVC = PostViewController()
//            self.navigationController?.pushViewController(postVC, animated: true)
//            postVC.postTitle = "Second Button"
            
            self.viewModel.post2DidTap()
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
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Feed"
        self.view.addSubview(stackView)
        stackView.addArrangedSubviews(firstButton, secondButton, feedTextfield, checkGuessButton, statusLabel)
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.backgroundColor = .white
        setupConstraints()
        
        let notify = NotificationCenter.default
        notify.addObserver(self, selector: #selector(passwordCorrect), name: Notification.Name("Correct"), object: nil)
        notify.addObserver(self, selector: #selector(passwordWrong), name: Notification.Name("Wrong"), object: nil)
    }
    
    //MARK: - passwordCheck
    @objc func passwordCorrect() {
        statusLabel.text = "Password Correct"
        statusLabel.textColor = .systemGreen
        statusLabel.isHidden = false
    }
    
    @objc func passwordWrong() {
        statusLabel.text = "Password Wrong"
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
//    @objc private func buttonTapped() {
//        let postVC = PostViewController()
//        navigationController?.pushViewController(postVC, animated: true)
//    }
}
