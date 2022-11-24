import Foundation
import FirebaseAuth
import UIKit

class LoginInspector: LoginViewControllerDelegate {
    
    func signUp(username: String, password: String) {
        Auth.auth().createUser(withEmail: username, password: password) { result, error in
            if let error = error {
                LogInViewController.signupError = error.localizedDescription
                NotificationCenter.default.post(name: Notification.Name("signupError"), object: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name("signupSuccess"), object: nil)
            }
        }
    }
    
    func signIn(username: String, password: String) {
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            if let error = error {
                LogInViewController.loginError = error.localizedDescription
                NotificationCenter.default.post(name: Notification.Name("loginError"), object: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name("loginSuccess"), object: nil)
            }
        }
    }
}
