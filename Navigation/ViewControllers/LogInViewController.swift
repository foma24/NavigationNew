import UIKit
import FirebaseAuth

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    var isLogin: Bool = false
    var delegate: LoginViewControllerDelegate?
    static var signupError: String?
    static var loginError: String?
    
    private lazy var loginScrollView: UIScrollView = {
        let loginScrollView = UIScrollView()
        loginScrollView.toAutoLayout()
        
        return loginScrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.toAutoLayout()
        
        return contentView
    }()
    
    private lazy var VKIcon: UIImageView = {
        let VKIcon = UIImageView()
        VKIcon.image = UIImage(named: "logo")
        VKIcon.toAutoLayout()
        
        return VKIcon
    }()
    
    private lazy var stackView: UIStackView = {
        let loginFormStackView = UIStackView()
        loginFormStackView.toAutoLayout()
        loginFormStackView.axis = .vertical
        loginFormStackView.layer.borderColor = UIColor.lightGray.cgColor
        loginFormStackView.layer.borderWidth = 0.5
        loginFormStackView.layer.cornerRadius = 10
        loginFormStackView.distribution = .fillProportionally
        loginFormStackView.backgroundColor = .systemGray6
        loginFormStackView.clipsToBounds = true
        
        return loginFormStackView
    }()
    
    private lazy var loginTextField: UITextField = {
        let loginTF = UITextField()
        loginTF.toAutoLayout()
        loginTF.leftViewMode = .always
        loginTF.placeholder = "Enter email or phone..."
        loginTF.layer.borderColor = UIColor.lightGray.cgColor
        loginTF.layer.borderWidth = 0.25
        loginTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: loginTF.frame.height))
        loginTF.keyboardType = .emailAddress
        loginTF.textColor = .black
        loginTF.font = UIFont.systemFont(ofSize: 16)
        loginTF.autocapitalizationType = .none
        loginTF.returnKeyType = .done
        
        return loginTF
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordTF = UITextField()
        passwordTF.toAutoLayout()
        passwordTF.leftViewMode = .always
        passwordTF.placeholder = "Password here..."
        passwordTF.layer.borderColor = UIColor.lightGray.cgColor
        passwordTF.layer.borderWidth = 0.25
        passwordTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTF.frame.height))
        passwordTF.isSecureTextEntry = true
        passwordTF.textColor = .black
        passwordTF.font = UIFont.systemFont(ofSize: 16)
        passwordTF.autocapitalizationType = .none
        passwordTF.returnKeyType = .done
        
        return passwordTF
    }()
    
    private lazy var signupButton: UIButton = {
        let signupButton = UIButton()
        signupButton.toAutoLayout()
        if let image = UIImage(named: "blue_pixel") {
            signupButton.setBackgroundImage(image.image(alpha: 1), for: .normal)
            signupButton.setBackgroundImage(image.image(alpha: 0.8), for: .selected)
            signupButton.setBackgroundImage(image.image(alpha: 0.8), for: .highlighted)
            signupButton.setBackgroundImage(image.image(alpha: 0.8), for: .disabled)
        }
        
        signupButton.setTitle("SignUp", for: .normal)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.addTarget(self, action: #selector(signupButtonPressed), for: .touchUpInside)
        signupButton.layer.cornerRadius = 10
        signupButton.clipsToBounds = true
        
        return signupButton
    }()
        
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.toAutoLayout()
        if let image = UIImage(named: "blue_pixel") {
            loginButton.setBackgroundImage(image.image(alpha: 1), for: .normal)
            loginButton.setBackgroundImage(image.image(alpha: 0.8), for: .selected)
            loginButton.setBackgroundImage(image.image(alpha: 0.8), for: .highlighted)
            loginButton.setBackgroundImage(image.image(alpha: 0.8), for: .disabled)
        }
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        
        return loginButton
    }()

    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        navigationController?.navigationBar.isHidden = true
        
        setupViews()
        
        //Keyboard hide
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.signupError), name: Notification.Name("signupError"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.signupSuccess), name: Notification.Name("signupSuccess"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loginError), name: Notification.Name("loginError"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.loginSuccess), name: Notification.Name("loginSuccess"), object: nil)
        
    }
    
    // MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if FirebaseAuth.Auth.auth().currentUser != nil {
            let profileVC = ProfileViewController()
            navigationController?.pushViewController(profileVC, animated: false)
        }
    }
    
    // MARK: - viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Setup View
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        contentView.addSubviews(VKIcon, stackView, loginButton, signupButton)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        setupConstraints()
    }
    
    
    // MARK: - Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: loginScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: loginScrollView.centerYAnchor),
            
            VKIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant:120),
            VKIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            VKIcon.heightAnchor.constraint(equalToConstant: 100),
            VKIcon.widthAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: VKIcon.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            signupButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            signupButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // MARK: - Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true;
    }
    
    @objc func tap() {
        passwordTextField.resignFirstResponder()
        loginTextField.resignFirstResponder()
    }
    
    @objc func keyboardShow(_ notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            loginScrollView.contentOffset.y = keyboardRectangle.height - (loginScrollView.frame.height - loginButton.frame.minY) + 16
        }
    }
    
    @objc func keyboardHide(_ notification: Notification){
        loginScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    // MARK: - SignUp
    @objc private func signupButtonPressed() {
        guard loginTextField.text?.isEmpty == false else {
            let alertVC = UIAlertController(title: "Error", message: "Login missed", preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            return }
        
        guard passwordTextField.text?.isEmpty == false else {
            let alertVC = UIAlertController(title: "Error", message: "Password missed", preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            return }
        
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let delegate = delegate else { return }
        
        delegate.signUp(username: login, password: password)
    }
    
    @objc func signupError() {
        if let signupError = LogInViewController.signupError {
            let alertVC = UIAlertController(title: "Error", message: "\(String(describing: signupError))", preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @objc func signupSuccess() {
        let alertVC = UIAlertController(title: "Done!", message: "You are signed up. You can Login", preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - Login button pressed
    @objc private func loginButtonPressed() {
        guard loginTextField.text?.isEmpty == false else {
            let alertVC = UIAlertController(title: "Error", message: "Login missed", preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            return }
        
        guard passwordTextField.text?.isEmpty == false else {
            let alertVC = UIAlertController(title: "Error", message: "Password missed", preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            return }
        
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let delegate = delegate else { return }
        
        delegate.signIn(username: login, password: password)
    }
    
    @objc func loginError() {
        if let loginError = LogInViewController.loginError {
            let alertVC = UIAlertController(title: "Error", message: "\(String(describing: loginError))", preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @objc func loginSuccess() {
        let profileVC = ProfileViewController()
        self.navigationController?.pushViewController(profileVC, animated: false)
    }
}
