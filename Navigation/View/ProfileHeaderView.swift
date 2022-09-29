import UIKit
import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    private(set) var statusText: String = ""
    static let identifire = "ProfileHeaderView"
    var defaultAvatarCenter: CGPoint = CGPoint(x: 0, y: 0)
    
    private lazy var plagView: UIView = {
        let plagView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        plagView.toAutoLayout()
        plagView.backgroundColor = .white
        plagView.alpha = 0
        
        return plagView
    }()
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.toAutoLayout()
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.black, for: .highlighted)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.closeTapped))
        closeButton.addGestureRecognizer(gesture)
        closeButton.isUserInteractionEnabled = true
        closeButton.alpha = 0
        
        return closeButton
    }()
    
    private(set) lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.toAutoLayout()
        avatarImageView.clipsToBounds = true
        avatarImageView.image = UIImage(named: "dog")
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.avatarTapped))
        avatarImageView.addGestureRecognizer(gesture)
        avatarImageView.isUserInteractionEnabled = true
        
        return avatarImageView
    }()
    
    private(set) lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.toAutoLayout()
        fullNameLabel.text = "Profile Name"
        fullNameLabel.textColor = .black
        fullNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return fullNameLabel
    }()
    
    private(set) lazy var setStatusButton: UIButton = {
        let setStatusButton = UIButton()
        setStatusButton.toAutoLayout()
        setStatusButton.backgroundColor = .blue
        setStatusButton.layer.cornerRadius = 12
        setStatusButton.setTitle("Set status", for: .normal)
        setStatusButton.setTitleColor(.lightGray, for: .highlighted)
        setStatusButton.addTarget(self, action: #selector(setStatus), for: .touchUpInside)
        
        return setStatusButton
    }()
    
    private(set) lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.toAutoLayout()
        statusLabel.text = "Status appears here..."
        statusLabel.numberOfLines = 2
        statusLabel.textColor = .gray
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        return statusLabel
    }()
    
    private(set) lazy var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.toAutoLayout()
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.cornerRadius = 12
        statusTextField.backgroundColor = .white
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: statusTextField.frame.height))
        statusTextField.leftViewMode = .always
        statusTextField.placeholder = "Set status"
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return statusTextField
    }()
    
    //MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Add Subviews
    func addView() {
        contentView.addSubviews(fullNameLabel, setStatusButton, statusTextField, statusLabel, plagView, closeButton, avatarImageView, closeButton)
        self.setupConstraints()
    }
    
    //MARK: - setupConstraints
    private func setupConstraints() {
        avatarImageView.snp.makeConstraints { constraint in
            constraint.width.equalTo(100)
            constraint.height.equalTo(100)
            constraint.leftMargin.equalTo(16)
            constraint.topMargin.equalTo(16)
        }
        
        fullNameLabel.snp.makeConstraints { constraint in
            constraint.left.equalTo(avatarImageView.snp.right).offset(20)
            constraint.top.equalTo(self.snp.top).offset(27)
        }
        
        setStatusButton.snp.makeConstraints { constraint in
            constraint.left.equalTo(self.snp.left).offset(16)
            constraint.right.equalTo(self.snp.right).offset(-16)
            constraint.top.equalTo(avatarImageView.snp.bottom).offset(42)
            constraint.height.equalTo(50)
        }
        
        statusLabel.snp.makeConstraints { constraint in
            constraint.left.equalTo(avatarImageView.snp.right).offset(20)
            constraint.bottom.equalTo(statusTextField.snp.top).offset(-6)
            constraint.right.greaterThanOrEqualTo(contentView.snp.right).offset(-16)
        }
        
        statusTextField.snp.makeConstraints { constraint in
            constraint.left.equalTo(avatarImageView.snp.right).offset(20)
            constraint.bottom.equalTo(setStatusButton.snp.top).offset(-10)
            constraint.right.greaterThanOrEqualTo(contentView.snp.right).offset(-16)
            constraint.height.equalTo(40)
        }
        
        closeButton.snp.makeConstraints { constraint in
            constraint.top.equalTo(contentView.snp.top).offset(16)
            constraint.right.equalTo(contentView.snp.right).offset(-16)
            constraint.width.equalTo(30)
            constraint.height.equalTo(30)
        }
    }
    
    //MARK: - statusTextChanged
    @objc func statusTextChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        statusText = text
    }
    
    //MARK: - setStatus
    @objc func setStatus() {
        if statusLabel.text != nil && statusText != "" {
            statusLabel.text = statusText
            statusTextField.text = ""
            statusTextField.resignFirstResponder()
        }
    }
    
    //MARK: - Tapped on avatar
    @objc func avatarTapped() {
        UIImageView.animate(withDuration: 0.5,
                            animations: {
            self.defaultAvatarCenter = self.avatarImageView.center
            self.avatarImageView.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
            self.avatarImageView.transform = CGAffineTransform(scaleX: self.contentView.frame.width / self.avatarImageView.frame.width, y: self.contentView.frame.width / self.avatarImageView.frame.width)
            self.avatarImageView.layer.cornerRadius = 0
            self.plagView.alpha = 0.9
            ProfileViewController.tableView.isScrollEnabled = false
            ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = false
            self.avatarImageView.isUserInteractionEnabled = false
        },
                            completion: { _ in
            UIImageView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 1
            }
        })
    }
    
    //MARK: - closeButtonTapped
    @objc func closeTapped() {
        UIImageView.animate(withDuration: 0.3,
                            animations: {
            self.closeButton.alpha = 0
        },
                            completion: { _ in
            UIImageView.animate(withDuration: 0.5) {
                self.avatarImageView.center = self.defaultAvatarCenter
                self.avatarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width / 2
                self.plagView.alpha = 0
                ProfileViewController.tableView.isScrollEnabled = true
                ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = true
                self.avatarImageView.isUserInteractionEnabled = true
            }
        })
    }
}
