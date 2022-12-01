import Foundation
import UIKit

final class LoginInspector: LoginViewControllerDelegate {

    let loginCheckerData = LoginChecker.shared
    
    func check(username: String, password: String, completion: @escaping (Bool) -> Void) {
        CheckerService.checkCredentials(login: username, password: password) { result in
            completion(result)
        }
    }

    func create(username: String, password: String, completion: @escaping (Bool) -> Void) {
        CheckerService.signUp(login: username, password: password) { result in
            completion(result)
        }
    }

}
